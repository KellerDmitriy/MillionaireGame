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
    var questionData: (easy: [Result], medium: [Result], hard: [Result]) {get set}
    func getQuestions()
}

final class HomePresenter: HomePresenterProtocol {
    var questionData: (easy: [Result], medium: [Result], hard: [Result]) = ([], [], [])
    weak var view: HomeViewProtocol?
    private let gameManager: GameManagerProtocol
    
    let router: HomeRouterProtocol
    
    init(router: HomeRouterProtocol, gameManager: GameManagerProtocol) {
        self.router = router
        self.gameManager = gameManager
    }
    
    func getQuestions(){
        Task{ @MainActor in
            do{
                questionData  = ([], [], []) //чистим для нового запроса
                try await gameManager.fetchQuestions()
                questionData = gameManager.questionData
                print("data \(questionData)")
            }catch{
                print(error.localizedDescription)
            }
           
        }
    }
}
