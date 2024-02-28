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
    var questEasyData: [OneQuestionModel] {get set}
    func routeToGame(data: [OneQuestionModel])
    
}

final class HomePresenter: HomePresenterProtocol {
    private let gameManager: GameManagerProtocol = GameManager(networkManager: NetworkManager())
    var questEasyData: [OneQuestionModel] = .init()
    weak var view: HomeViewProtocol?
    
    let router: HomeRouterProtocol
    init(router: HomeRouterProtocol) {
        self.router = router
        getEasyQuestions()
    }
    
    func routeToGame(data: [OneQuestionModel]) {
        router.routeToGame(data: data)
    }
    
    private func getEasyQuestions() {
          Task{ @MainActor in
              do{
                  questEasyData  = [] //чистим для нового запроса
                  let data = try await gameManager.fetchQuestions(difficulty: .easy)
                  questEasyData = data
                  //print(questEasyData)
              }catch{
                  print(error.localizedDescription)
              }
          }
      }
}

