//
//  SubTotalPresenter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import Foundation

protocol SubTotalViewProtocol: AnyObject {
    
}

protocol SubTotalPresenterProtocol {
    var numberQuestion: Int { get set }
}

final class SubTotalPresenter: SubTotalPresenterProtocol {
    var numberQuestion: Int
    
    weak var view: SubTotalViewProtocol?
    
    init(numberQuestion: Int) {
        self.numberQuestion = numberQuestion
    }
}
