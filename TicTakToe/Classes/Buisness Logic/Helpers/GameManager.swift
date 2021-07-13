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
    var currentGame: CurrentGame?
    
    // MARK: - Public Methods
    func startNewGame(userMark: MarkType, boardSize: Int) {
        currentGame = CurrentGame(userMark: userMark, boardSize: boardSize)
    }
    
    func addComputerMove() -> Move? {
        guard let currentGame = self.currentGame else { return nil}
        var movePosition = Int.random(in: 0..<currentGame.moves.count)
        
        while isMoveNotAllowed(position: movePosition) {
            movePosition = Int.random(in: 0..<currentGame.moves.count)
        }
        
        let move = Move(player: .computer, boardIndex: movePosition, mark: currentGame.computerMark)
        currentGame.moves[movePosition] = move
        return move
    }
    
    func isMoveNotAllowed(position: Int) -> Bool {
        guard let currentGame = self.currentGame else { return false}
        return currentGame.moves.compactMap { $0 }.contains(where: { $0.boardIndex == position })
    }
    
    func checkWinCondition(for player: Player) -> Bool {
        guard let currentGame = self.currentGame else { return false }
        var winPatterns: [[Int]] = []
        var horizontalPatterns: [[Int]] = []
        var pattern: [Int] = []
        for i in (0..<currentGame.moves.count) {
            pattern.append(i)
            if pattern.count == currentGame.boardSize {
                horizontalPatterns.append(pattern)
                pattern = []
            }
        }
        
        var verticalPatterns: [[Int]] = []
        var verticalIndex = 0
        
        while verticalIndex < currentGame.boardSize {
            for i in horizontalPatterns {
                let sortedPositions = i.sorted()
                pattern.append(sortedPositions[verticalIndex])
            }
            verticalPatterns.append(pattern)
            pattern = []
            verticalIndex += 1
        }
        
        var diagonalPatterns: [[Int]] = []
        var diagonalIndex = 0
        
        for i in verticalPatterns {
            let sortedPositions = i.sorted()
            pattern.append(sortedPositions[diagonalIndex])
            diagonalIndex += 1
        }
        diagonalPatterns.append(pattern)
        pattern = []
        
        diagonalIndex = currentGame.boardSize - 1
        
        for i in verticalPatterns {
            let sortedPositions = i.sorted()
            pattern.append(sortedPositions[diagonalIndex])
            diagonalIndex -= 1
        }
        diagonalPatterns.append(pattern)
        pattern = []
        
        winPatterns = horizontalPatterns + verticalPatterns + diagonalPatterns
        
        let playerMoves = currentGame.moves.compactMap({ $0 }).filter({ $0.player == player })
        let playerPositions = Set(playerMoves.map({ $0.boardIndex }))
        
        for condition in Set(winPatterns.map({ Set($0) })) where condition.isSubset(of: playerPositions) {
            return true
        }
        return false
    }
    
    func checkForDraw() -> Bool {
        guard let currentGame = self.currentGame else { return false }
        return currentGame.moves.compactMap({ $0 }).count == (currentGame.boardSize * currentGame.boardSize)
    }
    
    
    
}
