//
//  HomeRouter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    func routeToGame(data: [OneQuestionModel])
    func routeToRules()
}

final class HomeRouter: HomeRouterProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToGame(data: [OneQuestionModel]) {
        guard let navigationController else { return }
        let gameViewController = GameBuilder(navigationController: navigationController).build(data: data)
        navigationController.pushViewController(gameViewController, animated: true)
    }
    
    func routeToRules() {
        //
    }
}
