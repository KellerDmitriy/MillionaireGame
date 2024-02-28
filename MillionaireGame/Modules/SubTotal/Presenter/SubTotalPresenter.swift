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
    var userName: String { get }
    var score: Int { get set }
}

final class SubTotalPresenter: SubTotalPresenterProtocol {
    weak var view: SubTotalViewProtocol?
    
    var userName: String
    var numberQuestion: Int
    
    var score = 0
    
//    MARK: - Init
    init(userName: String, numberQuestion: Int) {
        self.userName = userName
        self.numberQuestion = numberQuestion
    }
    
}
