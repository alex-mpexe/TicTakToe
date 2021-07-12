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
    
    // MARK: - Initializers
    init(userMark: MarkType) {
        self.userMark = userMark
    }
    
}
