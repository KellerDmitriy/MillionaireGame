//
//  GameBuilder.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit

protocol GameBuilderProtocol: AnyObject {
    func build(userName: String, totalQuestion: Int) -> UIViewController
    init(navigationController: UINavigationController)
}

final class GameBuilder: GameBuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build(userName: String, totalQuestion: Int) -> UIViewController {
        guard let navigationController else {
            fatalError("GameBuilder requires a valid navigationController")
        }
        let viewController = GameViewController()
        let router = GameRouter(navigationController: navigationController)
        let networkManager = NetworkManager()
        let timeManager = TimeManager()
        let gameManager = GameManager(networkManager: networkManager)
        let presenter = GamePresenter(
            userName: userName, router: router,
            gameManager: gameManager,
            timeManager: timeManager,
            totalQuestion: totalQuestion
        )
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
}
