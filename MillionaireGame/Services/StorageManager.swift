//
//  StorageManager.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 03.03.2024.
//

import Foundation

protocol StorageManagerProtocol {
    var fullScore: [Score] { get set }
    func saveScore(name: String, score: String)
}

final class StorageManager: StorageManagerProtocol {
    let defaults = UserDefaults.standard
    static let shared = StorageManager()
    private let key = "users"
    
    var fullScore: [Score] {
        get {
            if let data = defaults.value(forKey: key) as? Data {
                if let users = try? PropertyListDecoder().decode([Score].self, from: data) {
                    return users
                }
            }
            return [Score]()
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: key)
            }
        }
    }
    
    func saveScore(name: String, score: String) {
        if let existingUser = fullScore.first(where: { $0.name == name }) {
            let updatedUser = Score(name: name, score: existingUser.score + score)
            fullScore = fullScore.filter { $0.name != name } + [updatedUser]
            fullScore = fullScore.sorted {$0.score > $1.score}
        } else {
            let user = Score(name: name, score: score)
            fullScore.append(user)
            fullScore = fullScore.sorted {$0.score > $1.score}
        }
    }
}
