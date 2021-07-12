//
//  StartScreenRouter.swift
//  TicTakToe
//
//  Created by Alexey on 12.07.2021.
//

import UIKit

struct StartScreenRouter: Router {

    let storyboard: UIStoryboard = UIStoryboard(name: "StartScreen", bundle: nil)
    weak var presenter: UIViewController?

    func presentStartScreen() {
        guard let vc = storyboard.instantiateInitialViewController() as? StartScreenVC else { return }
        presentModal(vc)
    }

    func showStartScreen() {
        guard let vc = storyboard.instantiateInitialViewController() as? StartScreenVC else { return }
        show(vc)
    }
    
    func setStartScreen() {
        guard let vc = storyboard.instantiateInitialViewController() as? StartScreenVC else { return }
        set(vc)
    }
}
