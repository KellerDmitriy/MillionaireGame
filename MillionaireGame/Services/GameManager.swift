//
//  GameManager.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import Foundation

protocol GameManagerProtocol{    
    func fetchQuestions(difficulty: Difficulty) async throws -> [OneQuestionModel]
    func helpFiftyFifty(data: OneQuestionModel) -> (String?, String?)
    func randomQuestion(data: OneQuestionModel, probability: Double) -> String? 
    func randomQuestionTappedFifty(data: [String], probability: Double) -> String?
    func createArrayIfFiftyFiftyTapped(answers: (String?, String?)) -> [String]
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
        case special = "&aacute;"
        case special1 = "&iacute;"
        case special2 = "&ntilde"
        
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
            case .special: return "á"
            case .special1: return "í"
            case .special2: return "ñ"
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
    
    func helpFiftyFifty(data: OneQuestionModel) -> (String?, String?){
        let correctAnswer = data.allAnswers.first(where: \.correct)
        let incorrectAnswers = data.allAnswers.filter { !$0.correct }
        let randomIncorrectAnswer = incorrectAnswers.randomElement()
        return (correctAnswer?.answerText, randomIncorrectAnswer?.answerText)
    }
    
    func randomQuestion(data: OneQuestionModel, probability: Double) -> String?{
        print("randomQuestion work")
        let correctAnswer = data.allAnswers.first(where: \.correct)
        let incorrectAnswers = data.allAnswers.filter { !$0.correct }
        let randomNumber = Double.random(in: 0...1) // generate a random number between 0 and 1
        if randomNumber < probability { // if the number is less than 0.7, return the correct answer
            return correctAnswer?.answerText
        } else { // otherwise, return a random incorrect answer
            let randomIncorrectAnswer = incorrectAnswers.randomElement()
            return randomIncorrectAnswer?.answerText
        }
    }
    
    func randomQuestionTappedFifty(data: [String], probability: Double) -> String?{
        print("randomQuestionTappedFifty work")
        let correctAnswer = data.first
        let incorrectAnswers = Array(data.dropFirst())
        let randomNumber = Double.random(in: 0...1)
        if randomNumber < probability {
            return correctAnswer
        } else {
            let randomIndex = Int.random(in: 0..<incorrectAnswers.count)
            return incorrectAnswers[randomIndex]
        }
    }
    
    func createArrayIfFiftyFiftyTapped(answers: (String?, String?)) -> [String] {
        guard let answer1 = answers.0, let answer2 = answers.1 else {return []}
        var array = [String]()
        array.append(answer1)
        array.append(answer2)
        array.shuffle()
        return array
    }
}
