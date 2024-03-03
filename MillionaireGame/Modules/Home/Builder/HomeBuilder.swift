//
//  HomeBuilder.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func build() -> UIViewController
    init(navigationController: UINavigationController)
}

final class HomeBuilder: BuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build() -> UIViewController {
        guard let navigationController else {
            fatalError("HomeBuilder requires a valid navigationController")
        }
        let viewController = HomeViewController()
        let storageManager = StorageManager()
        let router = HomeRouter(navigationController: navigationController)
        let presenter = HomePresenter(view: viewController, router: router, storageManager: storageManager)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
    
}
