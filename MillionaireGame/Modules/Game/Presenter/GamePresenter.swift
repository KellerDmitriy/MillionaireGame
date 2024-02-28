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
}

//Presenter
protocol ManageTimerProtocol{
    var progressToGamePublisher: Published<Float>.Publisher { get }
    
    func start30Timer()
    func stop30Timer()
    func start5Timer(music: String)
    
    func routeToSubTotal()
    func routeToResult()
}

protocol GamePresenterProtocol: ManageTimerProtocol {
    var numberQuestion: Int { get set }
    var questEasyData: [OneQuestionModel] { get set }
    var isLoaded: Bool { get set }
    var userName: String { get }
    func addToNumberQuestion()
}

final class GamePresenter: GamePresenterProtocol {

    private let gameManager: GameManagerProtocol
    private let timeManager: TimeManagerProtocol
    private let router: GameRouterProtocol
    
    @Published var progress: Float = 0.0
    var progressToGamePublisher: Published<Float>.Publisher { $progress }
    var questEasyData: [OneQuestionModel] = .init()
    var isLoaded = false
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
        getEasyQuestions()
    }
    
    func addToNumberQuestion() {
        numberQuestion += 1
    }
    
    func start30Timer() {
        timeManager.startTimer30Seconds()
    }
    
    func stop30Timer() {
        timeManager.stopTimer30Seconds()
    }
    
    func start5Timer(music: String) {
        timeManager.startTimer5Seconds(music: music)
    }
    
    func observeProgressBar() {
        timeManager.progresPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$progress)
    }
    
    private func getEasyQuestions() {
        Task{ @MainActor in
            do{
                questEasyData  = [] //чистим для нового запроса
                let data = try await gameManager.fetchQuestions(difficulty: .easy)
                questEasyData = data
                isLoaded = true
                view?.setUpUIWhenLoaded()
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
