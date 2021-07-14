//
//  Extensions.swift
//  TicTakToe
//
//  Created by Alexey on 14.07.2021.
//

import UIKit

extension UIStackView {
    func removeArrangedSubviews() {
        for subview in self.arrangedSubviews {
            self.removeArrangedSubview(subview)
        }
    }
}
