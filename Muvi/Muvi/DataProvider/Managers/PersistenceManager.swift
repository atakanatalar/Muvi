//
//  PersistenceManager.swift
//  Muvi
//
//  Created by Atakan Atalar on 26.08.2024.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    private let userDefaults = UserDefaults.standard
    private let resultsKey = "ResultsKey"
    
    private init() {}
    
    func saveResults(_ results: [Result]) {
        do {
            let encodedData = try JSONEncoder().encode(results)
            userDefaults.set(encodedData, forKey: resultsKey)
        } catch {
            print("Failed to encode results: \(error)")
        }
    }
    
    func loadResults() -> [Result] {
        guard let savedData = userDefaults.data(forKey: resultsKey) else {
            return []
        }
        
        do {
            let decodedResults = try JSONDecoder().decode([Result].self, from: savedData)
            return decodedResults
        } catch {
            print("Failed to decode results: \(error)")
            return []
        }
    }
    
    func addResult(_ result: Result) {
        var results = loadResults()
        if !results.contains(where: { $0.id == result.id }) {
            results.append(result)
            saveResults(results)
        }
    }
    
    func removeResult(by id: Int) {
        var results = loadResults()
        results.removeAll { $0.id == id }
        saveResults(results)
    }
    
    func resultExists(with id: Int) -> Bool {
        let results = loadResults()
        return results.contains { $0.id == id }
    }
}
