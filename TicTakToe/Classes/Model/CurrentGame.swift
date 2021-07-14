//
//  CurrentGame.swift
//  TicTakToe
//
//  Created by Alexey on 13.07.2021.
//

import Foundation

final class CurrentGame {
    
    // MARK: - Public properties
    var userMark: MarkType
    var computerMark: MarkType {
        switch userMark {
        case .xMark:
            return .oMark
        case .oMark:
            return .xMark
        }
    }
    var boardSize: Int
    var moves: [Move?]
    
    // MARK: - Initializers
    init(userMark: MarkType, boardSize: Int) {
        self.userMark = userMark
        self.boardSize = boardSize
        self.moves = Array(repeating: nil, count: (boardSize * boardSize))
    }
    
}

enum Player {
    case human
    case computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    let mark: MarkType
}
