//
//  HomeRouter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    func routeToAuth()
    func routeToRules(rulesText: String)
}

final class HomeRouter: HomeRouterProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToAuth() {
        guard let navigationController else { return }
        let authViewController = AuthBuilder(navigationController: navigationController).build()
        navigationController.pushViewController(authViewController, animated: true)
    }
    
    func routeToRules(rulesText: String) {
           let rulesViewController = RulesViewController(rulesText: rulesText)
           navigationController?.pushViewController(rulesViewController, animated: true)
       }
   }
