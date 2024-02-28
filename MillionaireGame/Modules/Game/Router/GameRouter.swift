//
//  GameRouter.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit

protocol GameRouterProtocol: AnyObject {
    func routeToResult()
    func routeToListQuestions()
}

final class GameRouter: GameRouterProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToResult() {
        //TODO: - Реализация перехода на финальный экран результатов
        
        guard let navigationController else { return }
        let resultViewController = ResultBuilder(navigationController: navigationController).build()
        navigationController.pushViewController(resultViewController, animated: true)
    }
    
    func routeToListQuestions() {
        //TODO: - Реализация перехода на экран со списком вопросов
    }
}
