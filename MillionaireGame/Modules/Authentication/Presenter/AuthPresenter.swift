//
//  HomePresenter.swift
//  MillionaireGame
//
//  Created by lukoom on 25.02.2024.
//

import Foundation

protocol AuthViewProtocol: AnyObject {
    
}

protocol AuthPresenterProtocol {
    var userName: String { get set }
    
    func routeToGame()
}

final class AuthPresenter: AuthPresenterProtocol {

    weak var view: HomeViewProtocol?
    
    private var textFieldText: String?
    
    let router: AuthRouterProtocol
    
    var userName: String {
            get {
                return textFieldText ?? ""
            }
            set {
                textFieldText = newValue
            }
        }
    
    init(router: AuthRouterProtocol) {
        self.router = router
    }
    
    func updateTextFieldText(_ text: String?) {
           textFieldText = text
       }
    
    func routeToGame() {
        router.routeToGame(userName: userName)
    }
    
}

