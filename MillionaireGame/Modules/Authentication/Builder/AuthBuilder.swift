//
//  HomeBuilder.swift
//  MillionaireGame
//
//  Created by lukoom on 25.02.2024.
//

import UIKit

final class AuthBuilder: BuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build() -> UIViewController {
        guard let navigationController else {
            fatalError("HomeBuilder requires a valid navigationController")
        }
        let viewController = AuthViewController()
        let router = AuthRouter(navigationController: navigationController)
        let presenter = AuthPresenter(router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
    
}

