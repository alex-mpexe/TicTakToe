//
//  GameScreenRouter.swift
//  TicTakToe
//
//  Created by Alexey on 12.07.2021.
//

import UIKit

struct GameScreenRouter: Router {

    let storyboard: UIStoryboard = UIStoryboard(name: "GameScreen", bundle: nil)
    weak var presenter: UIViewController?

    func presentGameScreen() {
        guard let vc = storyboard.instantiateInitialViewController() as? GameScreenVC else { return }
        presentModal(vc)
    }

    func showGameScreen() {
        guard let vc = storyboard.instantiateInitialViewController() as? GameScreenVC else { return }
        show(vc)
    }
    
    func pushGameScreen() {
        guard let vc = storyboard.instantiateInitialViewController() as? GameScreenVC else { return }
        push(vc)
    }
}
