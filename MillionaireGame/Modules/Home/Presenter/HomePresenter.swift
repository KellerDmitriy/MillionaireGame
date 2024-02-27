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
    var questEasyData: [Result] {get set}
    var questMediumData: [Result] {get set}
    var questHardData: [Result] {get set}
    func getQuestion(difficulty: Difficulty)
}

final class HomePresenter: HomePresenterProtocol {
    var questEasyData: [Result] = .init()
    var questMediumData: [Result] = .init()
    var questHardData: [Result] = .init()
    
    weak var view: HomeViewProtocol?
    private let gameManager: GameManagerProtocol
    
    let router: HomeRouterProtocol
    
    init(router: HomeRouterProtocol, gameManager: GameManagerProtocol) {
        self.router = router
        self.gameManager = gameManager
    }
    
    func getQuestion(difficulty: Difficulty) {
        switch difficulty{
        case .easy: getEasyQuestions()
        case .medium: getMediumQuestions()
        case .hard: getHardQuestions()
        }
    }
    
    private func getEasyQuestions() {
        Task{ @MainActor in
            do{
                questEasyData  = [] //чистим для нового запроса
                let data = try await gameManager.fetchQuestions(difficulty: .easy)
                questEasyData = data.0
                let answers = data.1
                print("data \(questEasyData)")
                print("dictAnswers \(answers)")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func getMediumQuestions() {
        Task{ @MainActor in
            do{
                questMediumData  = [] //чистим для нового запроса
                let data = try await gameManager.fetchQuestions(difficulty: .medium)
                questMediumData = data.0
                let answers = data.1
                print("dataMedium \(questMediumData)")
                print("dictAnswers \(answers)")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func getHardQuestions() {
        Task{ @MainActor in
            do{
                questHardData  = [] //чистим для нового запроса
                let data = try await gameManager.fetchQuestions(difficulty: .hard)
                questHardData = data.0
                let answers = data.1
                print("dataHard \(questHardData)")
                print("dictAnswers \(answers)")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
}

