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
    
    var score = 0
    
    //    MARK: - Init
    init(userName: String, router: SubTotalRouterProtocol, totalQuestion: Int, isCorrect: Bool) {
        self.userName = userName
        self.router = router
        self.totalQuestion = totalQuestion
        self.isCorrect = isCorrect
        print("get totaalQuestion subTotal \(totalQuestion) and isCorrect \(isCorrect)")
    }
    
    
    func moveGreenView() {
        if isCorrect {
            view?.updateUI(questionIndex: totalQuestion - 1) //так как сюда сразу 1 вопрос придет
        } else {
            view?.showLoseInfo(questionIndex: totalQuestion - 1)
        }
    }
    
    
    //MARK: - Navigation
    func routeToGame() {
        print("subTotal Presenter \(difficulty)")
        router.routeToGame(userName: userName, totalQuestion: totalQuestion)
    }
    
    func routeToResult() {
        router.routeToResult(name: userName, score: score, isLose: isCorrect)
    }
}
