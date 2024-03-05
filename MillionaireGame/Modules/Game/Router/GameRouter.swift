//
//  GameRouter.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit

protocol GameRouterProtocol: AnyObject {
    func routeToListQuestions(userName: String, totalQuestion: Int, isCorrect: Bool, timeManager: TimeManager)
    func routeToHome()
}

final class GameRouter: GameRouterProtocol {

    
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToListQuestions(userName: String, totalQuestion: Int, isCorrect: Bool, timeManager: TimeManager) {
        guard let navigationController else { return }
        
        let subTotalViewController = SubTotalBuilder(navigationController: navigationController).build(userName: userName, totalQuestion: totalQuestion, isCorrect: isCorrect, timeManager: timeManager)
        navigationController.pushViewController(subTotalViewController, animated: true)
    }
    
    func routeToHome() {
        guard let navigationController else { return }
        let homeViewController = HomeBuilder(navigationController: navigationController).build()
        navigationController.setViewControllers([homeViewController], animated: true)
    }
}
