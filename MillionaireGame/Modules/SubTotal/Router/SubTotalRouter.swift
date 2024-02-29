//
//  SubTotalRouter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 29.02.2024.
//

import UIKit

protocol SubTotalRouterProtocol: AnyObject {
    func routeToResult(userName: String, score: Int)
    func routeToGame(userName: String) 
}

final class SubTotalRouter: SubTotalRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToResult(userName: String, score: Int) {
        guard let navigationController else { return }
        let resultViewController = ResultBuilder(navigationController: navigationController).build()
        navigationController.pushViewController(resultViewController, animated: true)
    }
    
    func routeToGame(userName: String) {
        guard let navigationController else { return }
        let gameViewController = GameBuilder(navigationController: navigationController).build(userName: userName)
        navigationController.pushViewController(gameViewController, animated: true)
    }
}

