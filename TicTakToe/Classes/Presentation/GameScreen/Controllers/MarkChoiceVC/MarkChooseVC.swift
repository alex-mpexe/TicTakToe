//
//  MarkChooseVC.swift
//  TicTakToe
//
//  Created by Alexey on 13.07.2021.
//

import UIKit

class MarkChooseVC: UIViewController {
    
    // MARK: - Public properties
    var chosenMarkHandler: ((MarkType) -> Void)?
    
    // MARK: - IBActions
    @IBAction func xMarkChosen(_ sender: Any) {
        chosenMarkHandler?(.xMark)
    }
    @IBAction func oMarkChosen(_ sender: Any) {
        chosenMarkHandler?(.oMark)
    }
    
}
