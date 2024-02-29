//
//  GameRouter.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit

protocol GameRouterProtocol: AnyObject {
    func routeToResult()
    func routeToListQuestions(userName: String, totalQuestion: Int, isCorrect: Bool)
}

final class GameRouter: GameRouterProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToResult() {
        guard let navigationController else { return }
        let resultViewController = ResultBuilder(navigationController: navigationController).build()
        navigationController.pushViewController(resultViewController, animated: true)
    }
    
    func routeToListQuestions(userName: String, totalQuestion: Int, isCorrect: Bool) {
        guard let navigationController else { return }
        
        let subTotalViewController = SubTotalBuilder(navigationController: navigationController).build(userName: userName, totalQuestion: totalQuestion, isCorrect: isCorrect)
        navigationController.pushViewController(subTotalViewController, animated: true)
    }
}
