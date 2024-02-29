//
//  HomeRouter.swift
//  MillionaireGame
//
//  Created by lukoom on 25.02.2024.
//

import UIKit

protocol AuthRouterProtocol: AnyObject {
    func routeToGame(userName: String)
    
}

final class AuthRouter: AuthRouterProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToGame(userName: String) {
        guard let navigationController else { return }
        let gameViewController = GameBuilder(navigationController: navigationController).build(userName: userName, difficulty: .easy, totalQuestion: 0)
        navigationController.pushViewController(gameViewController, animated: true)
    }
}

