//
//  SubTotalBuilder.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit

protocol SubTotalBuilderProtocol {
    func build(numberQuestion: Int) -> UIViewController
    init(navigationController: UINavigationController)
}

final class SubTotalBuilder: SubTotalBuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build(numberQuestion: Int) -> UIViewController {
        guard let navigationController else {
            fatalError("SubTotalBuilder requires a valid navigationController")
        }
        let viewController = SubTotalViewController()
        let presenter = SubTotalPresenter(numberQuestion: numberQuestion)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
