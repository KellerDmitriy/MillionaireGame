//
//  SubTotalRouter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 29.02.2024.
//

import UIKit

protocol SubTotalRouterProtocol: AnyObject {
    func routeToResult(name: String, score: String, isLose: Bool)
    func routeToGame(userName: String, totalQuestion: Int)
}

final class SubTotalRouter: SubTotalRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToResult(name: String, score: String, isLose: Bool) {
        guard let navigationController else { return }
        let resultViewController = ResultBuilder(navigationController: navigationController).build(name: name, score: score, isLose: isLose)
        navigationController.pushViewController(resultViewController, animated: true)
    }
    
    func routeToGame(userName: String, totalQuestion: Int) {
        guard let navigationController else { return }

        navigationController.popViewController(animated: true) }
    
}

