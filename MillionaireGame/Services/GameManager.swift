//
//  GameManager.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import Foundation

protocol GameManagerProtocol{
    func fetchQuestions(difficulty: Difficulty) async throws -> ([Result], [String : [String: Bool]])
}

final class GameManager: GameManagerProtocol{
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchQuestions(difficulty: Difficulty) async throws -> ([Result], [String : [String: Bool]]) {
        let request = QuestionRequest(amount: 5, difficulty: difficulty.rawValue)
        let result = try await networkManager.request(request)
        let dictAnswers = getAnswers(result: result.results)
        return (result.results, dictAnswers)
    }
    
    private func getAnswers(result: [Result]) -> [String : [String: Bool]] {
        var dictAnswers = [String : [String : Bool]]()
        for element in result {
            var innerDict = [String : Bool]()
            for incorrectAnswer in element.incorrectAnswers {
                innerDict[incorrectAnswer] = false
            }
            innerDict[element.correctAnswer] = true
            if let decodedQuestion =  String(htmlEncodedString: element.question){
                dictAnswers[decodedQuestion] = innerDict
            } else {
                dictAnswers[element.question] = innerDict
            }
        }
        return dictAnswers
    }
}


