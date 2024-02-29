//
//  GamePresenter.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import Foundation

//ViewController
protocol GameViewProtocol: AnyObject {
    func setUpUIWhenLoaded()
    func activityIndicStop()
    func startTimer30Sec()
    func cleanUI()
}

//Presenter
protocol ManageTimerProtocol{
    var progressToGamePublisher: Published<Float>.Publisher { get }
    
    func start30Timer()
    func stop30Timer()
    func start5Timer(music: String, completion: @escaping () -> Void)
    
    func routeToSubTotal()
    func routeToResult()
}

protocol GamePresenterProtocol: ManageTimerProtocol {
    var numberQuestion: Int { get set }
    var questData: [OneQuestionModel] { get set }
    var isLoaded: Bool { get set }
    var userName: String { get }
    func tapOnAnswerButton()
    var waitCheckAnswer: Bool { get set }
    
    func loadEasyMediumHardData()
}

final class GamePresenter: GamePresenterProtocol {
    
    private let gameManager: GameManagerProtocol
    private let timeManager: TimeManagerProtocol
    private let router: GameRouterProtocol
    
    @Published var progress: Float = 0.0
    var progressToGamePublisher: Published<Float>.Publisher { $progress }
    var questData: [OneQuestionModel] = .init()
    var isLoaded = false
    var waitCheckAnswer = false
    
    var numberQuestion = 0
    var totalQuestion: Int
    var difficulty: Difficulty
    var userName = ""
    
    weak var view: GameViewProtocol?
    
    init(userName: String,
         router: GameRouterProtocol,
         gameManager: GameManagerProtocol,
         timeManager: TimeManagerProtocol,
         totalQuestion: Int,
         difficulty: Difficulty
         
    ) {
        self.userName = userName
        self.router = router
        self.gameManager = gameManager
        self.timeManager = timeManager
        self.totalQuestion = totalQuestion
        self.difficulty = difficulty
        
        observeProgressBar()
    }
    //MARK: - Check totalQuestion and Update UI for New Question
    func tapOnAnswerButton() {
        totalQuestion += 1
        checkTotalQuestion(totalQuestion: totalQuestion) // если не сделать numberQuestion = 0 то при переходе на другой уровень сложности вызовется view?.setUpUIWhenLoaded() и будет index out of range
        timeManager.set30TimerGoToSubtotal()
        view?.cleanUI()
        view?.setUpUIWhenLoaded()
    }
    
    //MARK: - Dowload Data for difficulty level
    func loadEasyMediumHardData(){
        if totalQuestion == 0 || totalQuestion == 5 || totalQuestion == 10  {
            print("load \(difficulty)")
            getQuestions(difficulty: difficulty)
        }
    }
    
    func start30Timer() {
        timeManager.startTimer30Seconds()
    }
    
    func stop30Timer() {
        timeManager.stopTimer30Seconds()
    }
    
    func start5Timer(music: String, completion: @escaping () -> Void) {
        timeManager.startTimer5Seconds(music: music, completion: completion)
    }
    
    func observeProgressBar() {
        timeManager.progresPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$progress)
    }
    
    private func checkTotalQuestion(totalQuestion: Int){
        switch totalQuestion{
        case 5, 10: numberQuestion = 0
        default: numberQuestion += 1 }
    }
    
    private func getQuestions(difficulty: Difficulty) {
        isLoaded = false
        Task{ @MainActor in
            do{
                questData  = [] //чистим для нового запроса
                let data = try await gameManager.fetchQuestions(difficulty: difficulty)
                questData = data
                print("difficulty \(difficulty) question Data \(questData)")
                isLoaded = true
                view?.setUpUIWhenLoaded()
                view?.activityIndicStop()
                view?.startTimer30Sec()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Navigation
    func routeToSubTotal() {
        router.routeToListQuestions(userName: userName, totalQuestion: totalQuestion)
    }
    
    func routeToResult() {
        router.routeToResult()
    }
}
