//
//  Game.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 30.11.21.
//

import Foundation

final class Game {
    
    static let shared = Game()
    
    var session: GameSession?
    
    private let resultsCaretaker = Momento()
    private(set) var results: [Result] {
        didSet {
            resultsCaretaker.save(results: self.results)
        }
    }
    
    private init() {
        self.results = self.resultsCaretaker.loadResults()
    }
    
    func getResult() {
        if let session = session {
            let score = Int((session.howMuchTrue * 100) / session.questionNumber)
            let result = Result(date: Date(), score: score)
            addResult(result)
            self.session = nil
        } else {
            debugPrint("Singletone - session is nil")
        }
    }
    
    func clearResult() {
        self.results = []
    }
    
    private func addResult(_ result: Result) {
        self.results.append(result)
    }
}
