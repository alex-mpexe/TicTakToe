//
//  GameScreenPresentationModel.swift
//  TicTakToe
//
//  Created by Alexey on 12.07.2021.
//

import UIKit

enum MarkType {
    case xMark
    case oMark
    
    var markName: String {
        switch self {
        case .xMark:
            return "xmark"
        case .oMark:
            return "omark"
        }
    }
}

class GameScreenPresentationModel {
    
    // MARK: - Public Properties
    var startGameHandler: (() -> Void)?
    
    // MARK: - Private Properties
    private let gameManager = GameManager.shared
    
    // MARK: - Public Methods
    func startGame(userMark: MarkType, boardSize: Int) {
        gameManager.startNewGame(userMark: userMark, boardSize: boardSize)
        startGameHandler?()
    }
    
}
