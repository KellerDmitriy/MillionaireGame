//
//  QuestionsModel.swift
//  MillionaireGame
//
//  Created by Polina on 26.02.2024.
//

import Foundation

// MARK: - QuestionsModel
struct QuestionsModel: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let  question, correctAnswer: String
    let incorrectAnswers: [String]
}

enum Difficulty: String {
    case easy
    case medium
    case hard
}

