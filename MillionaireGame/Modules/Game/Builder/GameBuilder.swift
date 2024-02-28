//
//  GameBuilder.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit

final class GameBuilder: BuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build() -> UIViewController {
        guard let navigationController else {
            fatalError("GameBuilder requires a valid navigationController")
        }
        let viewController = GameViewController()
        let router = GameRouter(navigationController: navigationController)
        let presenter = GamePresenter(router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
