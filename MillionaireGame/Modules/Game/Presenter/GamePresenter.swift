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
    func changeColorButton(isCorrect: Bool)
}

//Presenter
protocol ManageTimerProtocol{
    var progressToGamePublisher: Published<Float>.Publisher { get }
    
    func start30Timer()
    func stop30Timer()
    func start5Timer(music: String, completion: @escaping () -> Void)
    
    func start2Timer( completion: @escaping () -> Void)
    
    func routeToSubTotalOrResult(isCorrect: Bool)
}

protocol GamePresenterProtocol: ManageTimerProtocol {
    var numberQuestion: Int { get }
    var questData: [OneQuestionModel] { get }
    var isLoaded: Bool { get }
    var userName: String { get }
    var waitCheckAnswer: Bool { get }
    
    func loadEasyMediumHardData()
    func checkAnswer(answer:String)
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
    //MARK: - Check Correct Answer or not
    func checkAnswer(answer: String) {
        let correctAnswer = questData[numberQuestion].allAnswers.first(where: \.correct)
        let isCorrect = correctAnswer?.answerText == answer
        view?.changeColorButton(isCorrect: isCorrect)
    }
    //MARK: - Check totalQuestion
    func checkTotalQuestion() {
        totalQuestion += 1
        checkTotalQuestion(totalQuestion: totalQuestion) // если не сделать numberQuestion = 0 то при переходе на другой уровень сложности вызовется view?.setUpUIWhenLoaded() и будет index out of range
        setUPDefaultUI()
    }
    //MARK: -  Update UI for New Question
    private func setUPDefaultUI(){
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
    
    func start2Timer( completion: @escaping () -> Void) {
        timeManager.startTimer2Seconds(completion: completion)
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
    func routeToSubTotalOrResult(isCorrect: Bool) {
        if isCorrect{
            checkTotalQuestion()
            router.routeToListQuestions(userName: userName, totalQuestion: totalQuestion, isCorrect: isCorrect)
        } else{
            router.routeToResult()
        }
        
    }
}
