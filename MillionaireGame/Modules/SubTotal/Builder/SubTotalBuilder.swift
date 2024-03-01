//
//  SubTotalBuilder.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit

protocol SubTotalBuilderProtocol {
    func build(userName: String, totalQuestion: Int, isCorrect: Bool) -> UIViewController
    init(navigationController: UINavigationController)
}

final class SubTotalBuilder: SubTotalBuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build(userName: String, totalQuestion: Int, isCorrect: Bool) -> UIViewController {
        guard let navigationController else {
            fatalError("SubTotalBuilder requires a valid navigationController")
        }
        let viewController = SubTotalViewController()
        let router = SubTotalRouter(navigationController: navigationController)
        let presenter = SubTotalPresenter(userName: userName,
                                          router: router, totalQuestion: totalQuestion, isCorrect: isCorrect)
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
}
