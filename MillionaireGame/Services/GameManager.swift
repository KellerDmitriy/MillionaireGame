//
//  GameManager.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import Foundation

protocol GameManagerProtocol{    
    func fetchQuestions(difficulty: Difficulty) async throws -> [OneQuestionModel]
}

final class GameManager{
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    private func getArrayQustionsShuffle(result: [Result]) -> [OneQuestionModel] {
        var questionsArray: [OneQuestionModel] = []

        for element in result {
            var allAnswerss: [Answers] = []

            for incorrectAnswer in element.incorrectAnswers {
                let cleanInCorrectAnswer = cleanHtmlEntities(from: incorrectAnswer)
                allAnswerss.append(Answers(answerText: cleanInCorrectAnswer, correct: false))
            }
            let cleanCorrectAnswer = cleanHtmlEntities(from: element.correctAnswer)
            allAnswerss.append(Answers(answerText: cleanCorrectAnswer, correct: true))
            let cleanQuestion = cleanHtmlEntities(from: element.question)
            allAnswerss.shuffle()
            questionsArray.append(OneQuestionModel(question: cleanQuestion, allAnswers: allAnswerss))
        }

        return questionsArray
    }
   
    
    private func cleanHtmlEntities(from htmlEncodedString: String) -> String {
        var cleanedString = htmlEncodedString
        for entity in HTMLCharacterEntity.allCases {
            let cleanedStringWithEntity = cleanedString.replacingOccurrences(of: entity.rawValue, with: entity.replacementCharacter)
            cleanedString = cleanedStringWithEntity
        }
        return cleanedString
    }
    
    private enum HTMLCharacterEntity: String, CaseIterable {
        case doubleQuote = "&quot;"
        case apostrophe = "&#039;"
        case ampersand = "&amp;"
        case lessThan = "&lt;"
        case greaterThan = "&gt;"
        case copyright = "©"
        case registered = "®"
        case trademark = "™"
        case paragraph = "¶"
        case section = "§"
        
        var replacementCharacter: String {
            switch self {
            case .doubleQuote: return "\""
            case .apostrophe: return "'"
            case .ampersand: return "&"
            case .lessThan: return "<"
            case .greaterThan: return ">"
            case .copyright: return "©"
            case .registered: return "®"
            case .trademark: return "™"
            case .paragraph: return "¶"
            case .section: return "§"
            }
        }
    }
}

extension GameManager: GameManagerProtocol{
    func fetchQuestions(difficulty: Difficulty) async throws -> [OneQuestionModel] {
        let request = QuestionRequest(amount: 5, difficulty: difficulty.rawValue)
        let result = try await networkManager.request(request)
        let arrayQustionsShuffle = getArrayQustionsShuffle(result: result.results)
        return arrayQustionsShuffle
    }
}
