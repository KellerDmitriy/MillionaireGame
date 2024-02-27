//
//  HomePresenter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    
}

protocol HomePresenterProtocol {

}

final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    
    let router: HomeRouterProtocol
    
    init(router: HomeRouterProtocol) {
        self.router = router
    }
    

    
}

