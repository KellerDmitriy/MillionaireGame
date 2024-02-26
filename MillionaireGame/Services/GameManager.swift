//
//  GameManager.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import Foundation

protocol GameManagerProtocol{
    var questionData: (easy: [Result], medium: [Result], hard: [Result]) {get set}
    func fetchQuestions() async throws
}

final class GameManager: GameManagerProtocol{
    var questionData: (easy: [Result], medium: [Result], hard: [Result]) = ([], [], [])
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchQuestions() async throws{
        let requestEasy = QuestionRequest(amount: 5, difficulty: "easy")
        let requestMedium = QuestionRequest(amount: 5, difficulty: "medium")
        let requestHard = QuestionRequest(amount: 5, difficulty: "hard")
          
        let resultEasy = try await networkManager.request(requestEasy)
        try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
        let resultMedium = try await networkManager.request(requestMedium)
        try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
        let resultHard = try await networkManager.request(requestHard)
        questionData =  (resultEasy.results, resultMedium.results, resultHard.results)
    }
}
