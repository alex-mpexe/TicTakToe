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
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private lazy var presentationModel: GameScreenPresentationModel = {
        let model = GameScreenPresentationModel()
        
        model.startGameHandler = { [weak self] in
            self?.containerVC?.dismiss(animated: true, completion: {
                self?.containerVC?.view.removeFromSuperview()
                print("dissmised")
            })
        }
        
        return model
    }()
    
    private var containerVC: UIViewController?
    
    // MARK: - LC
    override func viewDidLoad() {
        super.viewDidLoad()
        setChooseMarkVC()
        setupMarkChoose()
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
    
    private func setupMarkChoose() {
        guard let markVC = containerVC as? MarkChooseVC else { return }
        markVC.chosenMarkHandler = { [weak self] markType in
            self?.presentationModel.startGame(userMark: markType, boardSize: 3)
        }
    }


}
