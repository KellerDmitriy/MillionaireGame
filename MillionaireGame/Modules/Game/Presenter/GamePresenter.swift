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
    func routeToResult()
    func start30Timer()
    func stop30Timer()
    func start5Timer(music: String)
    var progresToGamePublisher: Published<Float>.Publisher { get }
}

protocol GamePresenterProtocol: ManageTimerProtocol {
    var numberQuestion: Int { get set }
    func addToNumberQuestion()
    var questEasyData: [OneQuestionModel] { get set }
    var isLoaded: Bool { get set }
}

final class GamePresenter: GamePresenterProtocol {
    private let gameManager: GameManagerProtocol
    private let timeManager: TimeManagerProtocol
    private let router: GameRouterProtocol
    
    @Published var progrees: Float = 0.0
    var progresToGamePublisher: Published<Float>.Publisher { $progrees }
    var questEasyData: [OneQuestionModel] = .init()
    var isLoaded: Bool = false
    var numberQuestion: Int = 0
    
    weak var view: GameViewProtocol?
    
    init(router: GameRouterProtocol, gameManager: GameManagerProtocol, timeManager: TimeManagerProtocol ) {
        self.router = router
        self.gameManager = gameManager
        self.timeManager = timeManager
        observeProgressBar()
        getEasyQuestions()
    }
    
    func addToNumberQuestion() {
        numberQuestion += 1
    }
    
    func routeToResult() {
        router.routeToResult()
    }
    
    func start30Timer(){
        timeManager.startTimer30Seconds()
    }
    
    func stop30Timer() {
        timeManager.stopTimer30Seconds()
    }
    
    func start5Timer(music: String){
        timeManager.startTimer5Seconds(music: music)
    }
    
    func observeProgressBar(){
        timeManager.progresPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$progrees)
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
}
