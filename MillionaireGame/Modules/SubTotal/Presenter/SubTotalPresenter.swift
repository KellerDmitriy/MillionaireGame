//
//  SubTotalPresenter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import Foundation

protocol SubTotalViewProtocol: AnyObject {
    
}

protocol SubTotalPresenterProtocol {
    var userName: String { get }
    var score: Int { get set }
    
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
        checkDifficulty()
    }
    
    private func checkDifficulty(){
        if totalQuestion == 5 {
            print("5Check")
            difficulty = .medium
        } else if totalQuestion == 10 {
            difficulty = .hard
        } else{
            print("nothing change in check")
        }
    }
    
    func routeToGame() {
        print("subTotal Presenter \(difficulty)")
        router.routeToGame(userName: userName, totalQuestion: totalQuestion, difficulty: difficulty)
    }
    
    func routeToResult() {
        router.routeToResult(userName: userName, score: score)
    }
}
