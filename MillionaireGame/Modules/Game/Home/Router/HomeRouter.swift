//
//  HomeRouter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    func routeToGame()
    func routeToRules(rulesText: String)
}

final class HomeRouter: HomeRouterProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToGame() {

    }
    
    func routeToRules(rulesText: String) {
        let rulesViewController = RulesViewController(rulesText: rulesText)
        navigationController?.pushViewController(rulesViewController, animated: true)
    }
}
