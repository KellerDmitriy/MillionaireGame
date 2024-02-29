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
    func addToNumberQuestion()
    var waitCheckAnswer: Bool { get set }
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
    var userName = ""
    weak var view: GameViewProtocol?
    
    init(userName: String,
         router: GameRouterProtocol,
         gameManager: GameManagerProtocol,
         timeManager: TimeManagerProtocol
    ) {
        self.userName = userName
        self.router = router
        self.gameManager = gameManager
        self.timeManager = timeManager
        
        observeProgressBar()
        getQuestions(difficulty: .easy)
    }
    
    func addToNumberQuestion() {
        if !checkDifficulty(numberQuestion: numberQuestion) {
            print("add")
            numberQuestion += 1
        } else{
            print("not add")
            numberQuestion = 0
        }
        timeManager.set30TimerGoToSubtotal()
        view?.cleanUI()
        view?.setUpUIWhenLoaded()
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
    
    private func checkDifficulty(numberQuestion: Int) -> Bool {
        if numberQuestion == 4 {
            getQuestions(difficulty: .medium)
            //numberQuestion = 0
            return true
        } else if numberQuestion == 9 {
            getQuestions(difficulty: .hard)
            //numberQuestion = 0
            return true
        }
        return false
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
        router.routeToListQuestions(userName: userName, numberQuestion: numberQuestion)
    }
    
    func routeToResult() {
        router.routeToResult()
    }
}
