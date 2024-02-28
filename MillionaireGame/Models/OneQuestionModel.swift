//
//  OneQuestionModel.swift
//  MillionaireGame
//
//  Created by Polina on 28.02.2024.
//

import Foundation

struct OneQuestionModel {
    let question: String
    let allAnswers: [Answers]
}

struct Answers {
    let answerText: String
    let correct: Bool
}
