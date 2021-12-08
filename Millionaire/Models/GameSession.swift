//
//  GameSession.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 30.11.21.
//

import Foundation

final class GameSession {
    
    let time = Date.now
    var questions: [Question] = []
    var questionNumber = Observable<Int>(0)
    var howMuchTrue: Int = 0
    var howMuchFalse: Int = 0
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
}
