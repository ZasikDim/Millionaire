//
//  Question.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 30.11.21.
//

import Foundation

struct Question: Codable {
    
    let question: String
    let answers: [Answer]
    let correctAnswer: String
    
}
