//
//  GameBuilder.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit

protocol GameBuilderProtocol: AnyObject {
    func build(data: [OneQuestionModel]) -> UIViewController
    init(navigationController: UINavigationController)
}

final class GameBuilder: GameBuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build(data: [OneQuestionModel]) -> UIViewController {
        guard let navigationController else {
            fatalError("GameBuilder requires a valid navigationController")
        }
        let viewController = GameViewController()
        let router = GameRouter(navigationController: navigationController)
        let presenter = GamePresenter(router: router, data: data)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
