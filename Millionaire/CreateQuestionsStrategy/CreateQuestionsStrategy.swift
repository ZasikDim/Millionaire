//
//  CreateQuestionsStrategy.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 03.12.21.
//

import Foundation

enum OrderOfQuestions {
    case random, straight
}

protocol CreateQuestionsStrategy {
    func createQuestions(for questions: [Question]) -> [Question]
}
