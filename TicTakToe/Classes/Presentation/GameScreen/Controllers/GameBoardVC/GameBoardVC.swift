//
//  GameBoardVC.swift
//  TicTakToe
//
//  Created by Alexey on 13.07.2021.
//

import UIKit

class GameBoardVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var boardStackView: UIStackView!
    
    // MARK: - Private properties
    private lazy var presentationModel: GameBoardPresentationModel = {
        let model = GameBoardPresentationModel()
        
        model.boardSizeHandler = { [weak self] size in
            self?.setupGameBoard(with: size)
        }
        
        model.userMarkHandler = { [weak self] mark in
            self?.userMark = mark
        }
        
        model.moveHandler = { [unowned self] move in
            print(self.isGameEnded)
            if !self.isGameEnded {
                self.selectCell(move: move)
                if model.checkWinCondition(for: move.player) {
                    self.isGameEnded = true
                    self.showAlert(isDraw: false, winPlayer: move.player)
                    model.updateScore(isHumanWin: move.player == .human)
                    return
                }
                if model.checkForDraw() {
                    self.isGameEnded = true
                    self.showAlert(isDraw: true, winPlayer: nil)
                    return
                }
            }
        }
        
        return model
    }()
    
    private var isGameEnded = false
    
    private var isHumanTurn = false {
        didSet {
            if !isHumanTurn {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                    self?.presentationModel.addComputerMove()
                })
            }
        }
    }
    private var userMark: MarkType! {
        didSet {
            self.isHumanTurn = userMark == .some(.xMark)
        }
    }
    
    // MARK: - LC
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationModel.getBoardSize()
        presentationModel.getUserMark()
    }
    
    // MARK: - IBActions
    @IBAction func BackButtonPressed(_ sender: Any) {
        guard let parent = parent else { return }
        StartScreenRouter(presenter: parent).setToRoot()
    }
    @IBAction func refrashButtonPressed(_ sender: Any) {
        reloadGame()
    }
    
    
    // MARK: - Private methods
    private func setupGameBoard(with size: Int) {
        if let stacks = boardStackView.arrangedSubviews as? [UIStackView] {
            stacks.forEach { stack in
                stack.removeFromSuperview()
            }
            boardStackView.removeArrangedSubviews()
        }
        var index = 0
        for _ in 0..<size {
            let stackView = UIStackView(frame: .zero)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 5
            for _ in 0..<size {
                let cell = UIImageView(frame: .zero)
                cell.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0.5)
                cell.isUserInteractionEnabled = true
                cell.layer.cornerRadius = 20
                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellSelected)))
                cell.tag = index
                stackView.addArrangedSubview(cell)
                index += 1
            }
            boardStackView.addArrangedSubview(stackView)
        }
    }
    
    @objc func cellSelected(_ sender: AnyObject) {
        guard let tag = sender.view?.tag else { return }
        if !presentationModel.isCellOccupied(tag: tag) && isHumanTurn {
            self.presentationModel.addMove(indicator: tag, isHumanTurn: isHumanTurn)
        }
    }
    
    private func selectCell(move: Move) {
        guard let cells = boardStackView.arrangedSubviews.compactMap { ($0 as? UIStackView)?.arrangedSubviews }.flatMap { $0 } as? [UIImageView] else { return }
        if let cell = cells.first(where: { $0.tag == move.boardIndex }) {
            cell.image = UIImage(named: move.mark.markName)
            isHumanTurn.toggle()
        }
    }
    
    private func showAlert(isDraw: Bool, winPlayer: Player?) {
        if isDraw {
            let alertController = UIAlertController(title: "Draw", message: "Good luck next time!", preferredStyle: UIAlertController.Style.alert)
            alertController.view.tintColor = #colorLiteral(red: 0.9450980392, green: 0.4509803922, blue: 0, alpha: 1)
            let action = UIAlertAction(title: "Play again", style: .default) { _ in
                self.reloadGame()
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        } else if let player = winPlayer {
            let alertController = UIAlertController(title: player == .some(.human) ? "WIN!" : "LOSE :(", message: player == .some(.human) ? "Geat, you are the best!" : "Good luck next time!", preferredStyle: UIAlertController.Style.alert)
            alertController.view.tintColor = #colorLiteral(red: 0.9450980392, green: 0.4509803922, blue: 0, alpha: 1)
            let action = UIAlertAction(title: "Play again", style: .default) { _ in
                self.reloadGame()
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func reloadGame() {
        isGameEnded = false
        presentationModel.reloadGame()
    }

}
