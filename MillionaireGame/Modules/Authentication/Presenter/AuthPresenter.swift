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
    var name: String? { get set }
}

final class AuthPresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    
    private var textFieldText: String?
    
    let router: AuthRouterProtocol
    init(router: AuthRouterProtocol) {
        self.router = router
    }
    
    func updateTextFieldText(_ text: String?) {
           textFieldText = text
       }
    
    var name: String? {
            get {
                return textFieldText
            }
            set {
                textFieldText = newValue
            }
        }
    
}

