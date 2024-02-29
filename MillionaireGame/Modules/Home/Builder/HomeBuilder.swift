//
//  HomeBuilder.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

protocol HomeBuilderProtocol: AnyObject {
    func build() -> UIViewController
    init(navigationController: UINavigationController)
}

final class HomeBuilder: HomeBuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build() -> UIViewController {
        guard let navigationController else {
            fatalError("HomeBuilder requires a valid navigationController")
        }
        let viewController = HomeViewController()
        let router = HomeRouter(navigationController: navigationController)
        let presenter = HomePresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
    
}
