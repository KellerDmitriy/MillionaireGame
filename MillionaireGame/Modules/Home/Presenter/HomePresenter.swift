//
//  HomePresenter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
}

protocol HomePresenterProtocol {
    func startGame()
    func showRules()
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    let router: HomeRouterProtocol
    
    init(view: HomeViewProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func startGame() {
        router.routeToGame()
    }
    
    func showRules() {
        let rulesText = """
            1. You will have to answer 15 questions, each of which increases your winnings.
        
            2. Questions are divided into several levels of difficulty, from easy to difficult.
        
            3. You have 4 answer options for each question.
        
            4. Choose the correct answer to progress further and win more money.
        
            5. If the answer is incorrect, you may lose part or all of your current winnings.
        
            6. You have 3 "helpers":
        1 - "50:50" (remove two incorrect answer options),
        2 - "Ask the Audience" (get statistics on audience responses),
        3 - "Phone a Friend" (call a friend for advice).
        
            7. If you answer all 15 questions correctly, you win a million!
        
            Good luck!
        """
        router.routeToRules(rulesText: rulesText)
    }
}
