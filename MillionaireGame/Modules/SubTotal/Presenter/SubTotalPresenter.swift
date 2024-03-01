//
//  SubTotalPresenter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import Foundation

protocol SubTotalViewProtocol: AnyObject {
    func continueButtonTap()
    func showLoseInfo(questionIndex: Int)
    func updateUI(questionIndex: Int)
    
}

protocol SubTotalPresenterProtocol {
    var userName: String { get }
    var score: Int { get set }
    var isCorrect: Bool { get }
    
    func moveGreenView()
    func playMusicIsCorrect()
    
    func routeToGame()
    func routeToResult()
}

final class SubTotalPresenter: SubTotalPresenterProtocol {
    
    weak var view: SubTotalViewProtocol?
    private let router: SubTotalRouterProtocol
    
    var userName: String
    var totalQuestion: Int
    var difficulty: Difficulty = .easy
    var isCorrect: Bool
    
    let timeManager: TimeManager
    
    var score = 0
    
    //    MARK: - Init
    init(userName: String, router: SubTotalRouterProtocol, totalQuestion: Int, isCorrect: Bool, timeManager: TimeManager) {
        self.userName = userName
        self.router = router
        self.totalQuestion = totalQuestion
        self.isCorrect = isCorrect
        self.timeManager = timeManager
        print("get totaalQuestion subTotal \(totalQuestion) and isCorrect \(isCorrect)")
    }
    
    
    func moveGreenView() {
        if isCorrect {
            view?.updateUI(questionIndex: totalQuestion - 1) //так как сюда сразу 1 вопрос придет
        } else {
            view?.showLoseInfo(questionIndex: totalQuestion - 1)
        }
    }
    
    func playMusicIsCorrect() {
        let music = isCorrect ? "otvet-vernyiy" : "zvuk-nepravilnogo-otveta"
        start5Timer(music: music)
    }
    
    private func start5Timer(music: String) {
        timeManager.startTimer5Seconds(music: music, completion: doSome)
    }
    
    func doSome(){}
    
    
    //MARK: - Navigation
    func routeToGame() {
        print("subTotal Presenter \(difficulty)")
        router.routeToGame(userName: userName, totalQuestion: totalQuestion)
    }
    
    func routeToResult() {
        router.routeToResult(name: userName, score: score, isLose: isCorrect)
    }
}
