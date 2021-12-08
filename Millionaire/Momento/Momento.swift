//
//  Momento.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 01.12.21.
//

import Foundation

typealias Memento = Data

final class Momento {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "results"
    
    func save(results: [Result]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func loadResults() -> [Result] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Result].self, from: data)
        } catch {
            debugPrint(error)
            return []
        }
    }
}
