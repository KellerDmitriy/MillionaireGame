//
//  HomeRouter.swift
//  MillionaireGame
//
//  Created by lukoom on 25.02.2024.
//

import UIKit

protocol AuthRouterProtocol: AnyObject {
    func routeToGame()
    
}

final class AuthRouter: AuthRouterProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToGame() {
        //
    }
}

