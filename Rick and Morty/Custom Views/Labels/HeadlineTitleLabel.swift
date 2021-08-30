//
//  HeadlineTitleLabel.swift
//  Rick and Morty
//
//  Created by Kate on 21.07.2021.
//

import UIKit

class HeadlineTitleLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        configure(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(text: String) {
        self.text = text
        font = UIFont.boldSystemFont(ofSize: 24)
        textAlignment = .center
        textColor = .customGreen
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
    }
}
