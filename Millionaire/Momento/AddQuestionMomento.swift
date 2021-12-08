//
//  AddQuestionMomento.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 07.12.21.
//

import Foundation

final class AddQuestionMomento {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "question"
    
    func save(questions: [Question]) {
        do {
            let data = try self.encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func loadQuestion() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            debugPrint(error)
            return []
        }
    }
}
