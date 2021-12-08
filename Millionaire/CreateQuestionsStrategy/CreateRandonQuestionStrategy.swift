//
//  CreateRandonQuestionStrategy.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 03.12.21.
//

import Foundation

final class CreateRandonQuestionStrategy: CreateQuestionsStrategy {
    
    func createQuestions(for questions: [Question]) -> [Question] {
        let questions = questions.shuffled()
        return questions
    }
    
}
