//
//  NormalTextLabel.swift
//  Rick and Morty
//
//  Created by Kate on 12.08.2021.
//

import UIKit

class NormalTextLabel: UILabel {
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textAlignment = .left
        textColor = .white
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        numberOfLines = 2
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
