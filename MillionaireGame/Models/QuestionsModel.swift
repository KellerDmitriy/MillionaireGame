//
//  QuestionsModel.swift
//  MillionaireGame
//
//  Created by Polina on 26.02.2024.
//

import Foundation

// MARK: - QuestionsModel
struct QuestionsModel: Decodable {
    //let responseCode: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    //let type: TypeEnum
    //let difficulty: Difficulty
    let  question, correctAnswer: String
    let incorrectAnswers: [String]
}

enum Difficulty: String, Decodable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

enum TypeEnum: String, Decodable {
    case boolean = "boolean"
    case multiple = "multiple"
}
