//
//  StartScreenVC.swift
//  TicTakToe
//
//  Created by Alexey on 12.07.2021.
//

import UIKit

class StartScreenVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            playButton.layer.cornerRadius = playButton.frame.size.height / 2
        }
    }
    @IBOutlet weak var computerScoreLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private lazy var presentationModel: StartScreenPresentationModel = {
        let model = StartScreenPresentationModel()
        
        model.statisticsHandler = { [weak self] userScore, computerScore in
            self?.updateGameScore(userScore, computerScore)
        }
        
        return model
    }()

    // MARK: - LC
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationModel.getGameScore()
    }
    
    // MARK: - Private methods
    private func updateGameScore(_ userScore: Int, _ computerScore: Int) {
        playerScoreLabel.text = "\(userScore)"
        computerScoreLabel.text = "\(computerScore)"
    }
    
    // MARK: - IBActions
    @IBAction func PlayButtonPressed(_ sender: Any) {
    }
    
}
