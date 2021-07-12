//
//  GameManager.swift
//  TicTakToe
//
//  Created by Alexey on 12.07.2021.
//

import Foundation

final class GameManager {
    
    // MARK: - Singleton
    static let shared = GameManager()
    
    // MARK: - Initializers
    private init() {
        
    }
    
    // MARK: - Public Properties
    enum GameState {
        case started
        case ended
    }
    
    var userScore = 0
    var computerScore = 0
    
    
    
}
