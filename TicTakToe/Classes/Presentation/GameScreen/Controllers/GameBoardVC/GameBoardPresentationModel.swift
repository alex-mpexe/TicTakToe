//
//  GameBoardPresentationModel.swift
//  TicTakToe
//
//  Created by Alexey on 13.07.2021.
//

import Foundation

class GameBoardPresentationModel {
    
    // MARK: - Public Properties
    var boardSizeHandler: ((Int) -> Void)?
    var userMarkHandler: ((MarkType) -> Void)?
    var moveHandler: ((Move) -> Void)?
    
    // MARK: - Private Properties
    private let gameManager = GameManager.shared
    private let cacheManager = CacheService.shared
    
    // MARK: - Public methods
    func getBoardSize() {
        guard let currentGame = gameManager.currentGame else { return }
        boardSizeHandler?(currentGame.boardSize)
    }
    
    func getUserMark() {
        guard let currentGame = gameManager.currentGame else { return }
        userMarkHandler?(currentGame.userMark)
    }
    
    func addMove(indicator: Int, isHumanTurn: Bool) {
        guard let currentGame = gameManager.currentGame else { return }
        let move = Move(player: isHumanTurn ? .human : .computer, boardIndex: indicator, mark: isHumanTurn ? currentGame.userMark : currentGame.computerMark)
        currentGame.moves[indicator] = move
        moveHandler?(move)
    }
    
    func isCellOccupied(tag: Int) -> Bool {
        return gameManager.isMoveNotAllowed(position: tag)
    }
    
    func addComputerMove() {
        if let move = gameManager.addComputerMove() {
            moveHandler?(move)
        }
    }
    
    func checkWinCondition(for player: Player) -> Bool {
        return gameManager.checkWinCondition(for: player)
    }
    
    func checkForDraw() -> Bool {
        return gameManager.checkForDraw()
    }
    
    func updateScore(isHumanWin: Bool) {
        cacheManager.addGameResult(isUserWin: isHumanWin)
    }
    
    func reloadGame() {
        guard let cureentGame = gameManager.currentGame else { return }
        gameManager.currentGame = CurrentGame(userMark: cureentGame.userMark, boardSize: cureentGame.boardSize)
        boardSizeHandler?(cureentGame.boardSize)
        userMarkHandler?(cureentGame.userMark)
    }
}
