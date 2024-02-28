//
//  SubTotalBuilder.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit

final class SubTotalBuilder: BuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build() -> UIViewController {
        guard let navigationController else {
            fatalError("SubTotalBuilder requires a valid navigationController")
        }
        let viewController = SubTotalViewController()
        let presenter = SubTotalPresenter()
        
        viewController.presenter = presenter
        
        return viewController
    }
}
