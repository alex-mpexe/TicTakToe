//
//  CacheService.swift
//  TicTakToe
//
//  Created by Alexey on 12.07.2021.
//

import Foundation

final class CacheService {
    
    // MARK: - Singleton
    static let shared = CacheService()
    
    // MARK: - Private properties
    private let defaults = UserDefaults.standard
    
    // MARK: - Initializers
    private init() {
        
    }
    
    // MARK: - Public methods
    func addGameResult(isUserWin: Bool) {
        let key = isUserWin ? userScoreKey : computerScoreKey
        var savedData = defaults.object(forKey: key) as? Int ?? 0
        defaults.set(savedData += 1, forKey: key)
    }
    
    func getStatistics() {
        GameManager.shared.userScore = defaults.object(forKey: userScoreKey) as? Int ?? 0
        GameManager.shared.computerScore = defaults.object(forKey: computerScoreKey) as? Int ?? 0
    }
    
}
