//
//  StartScreenPresentationModel.swift
//  TicTakToe
//
//  Created by Alexey on 12.07.2021.
//

import UIKit

class StartScreenPresentationModel {
    
    // MARK: - Public Properties
    var statisticsHandler: ((Int, Int) -> Void)?
    
    // MARK: - Pivate Properties
    private let cacheManager = CacheService.shared
    private let gameManager = GameManager.shared
    
    // MARK: - Public Methods
    func getGameScore() {
        cacheManager.getStatistics()
        statisticsHandler?(gameManager.userScore, gameManager.computerScore)
    }
    
}
