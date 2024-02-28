//
//  GamePresenter.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import Foundation

//ViewController
protocol GameViewProtocol: AnyObject {
    
}

//Presenter
protocol GamePresenterProtocol {
    func routeToResult()
    func start30Timer()
    func stop30Timer()
    func start5Timer(music: String)
    var progresToGamePublisher: Published<Float>.Publisher { get }
    var dataEasy: [OneQuestionModel] {get set}
}

final class GamePresenter: GamePresenterProtocol {
    let timerManager: TimeManagerProtocol = TimeManager()
    @Published var progrees: Float = 0.0
    var progresToGamePublisher: Published<Float>.Publisher { $progrees }
    
    weak var view: GameViewProtocol?
    
    let router: GameRouterProtocol
    var dataEasy: [OneQuestionModel]
    init(router: GameRouterProtocol, data: [OneQuestionModel]) {
        self.router = router
        self.dataEasy = data
        observeProgressBar()
    }
    
    func routeToResult() {
        router.routeToResult()
    }
    
    func start30Timer(){
        timerManager.startTimer30Seconds()
    }
    
    func stop30Timer() {
        timerManager.stopTimer30Seconds()
    }
    
    func start5Timer(music: String){
        timerManager.startTimer5Seconds(music: music)
    }
    
    func observeProgressBar(){
        timerManager.progresPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$progrees)
    }
    
}
