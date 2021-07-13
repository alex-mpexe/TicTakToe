//
//  GameScreenVC.swift
//  TicTakToe
//
//  Created by Alexey on 12.07.2021.
//

import UIKit

class GameScreenVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Private Properties
    private lazy var presentationModel: GameScreenPresentationModel = {
        let model = GameScreenPresentationModel()
        
        model.startGameHandler = { [weak self] in
            self?.navigateToStartGame()
        }
        
        return model
    }()
    
    private var containerVC: UIViewController?
    
    // MARK: - LC
    override func viewDidLoad() {
        super.viewDidLoad()
        setChooseMarkVC()
        setupMarkChooseVC()
    }
    
    // MARK: - Private Methods
    private func setChooseMarkVC() {
        containerVC = MarkChooseVC()
        guard let containerVC = self.containerVC else { return }
        containerVC.willMove(toParent: self)
        containerVC.view.frame = containerView.bounds
        containerView.addSubview(containerVC.view)
        addChild(containerVC)
        containerVC.didMove(toParent: self)
    }
    
    private func setupMarkChooseVC() {
        guard let markVC = containerVC as? MarkChooseVC else { return }
        markVC.chosenMarkHandler = { [weak self] markType in
            self?.presentationModel.startGame(userMark: markType, boardSize: 3)
        }
    }
    
    private func setupGameBoardVC() {
        containerVC = GameBoardVC()
        guard let containerVC = self.containerVC else { return }
        containerVC.willMove(toParent: self)
        containerVC.view.frame = containerView.bounds
        containerView.addSubview(containerVC.view)
        addChild(containerVC)
        containerVC.didMove(toParent: self)
    }
    
    private func navigateToStartGame() {
        UIView.animate(withDuration: 1, animations: {
            self.containerVC?.view.alpha = 0
            self.titleLabel.alpha = 0
        }, completion: { _ in
            self.containerVC?.view.removeFromSuperview()
            self.setupGameBoardVC()
            self.titleLabel.text = "Tic-Tac-Toe"
            UIView.animate(withDuration: 0.2, animations: {
                self.titleLabel.alpha = 1
            })
        })
    }
}
