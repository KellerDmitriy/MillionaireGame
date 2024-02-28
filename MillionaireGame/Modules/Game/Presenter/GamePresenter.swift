//
//  GamePresenter.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import Foundation

//ViewController
protocol GameViewProtocol: AnyObject {
    
}

//Presenter
protocol GamePresenterProtocol {
    func routeToResult()
}

final class GamePresenter: GamePresenterProtocol {
    
    weak var view: GameViewProtocol?
    
    let router: GameRouterProtocol
    init(router: GameRouterProtocol) {
        self.router = router
    }
    
    func routeToResult() {
        router.routeToResult()
    }
    
}
