//
//  SubheadlineTitleLabel.swift
//  Rick and Morty
//
//  Created by Kate on 30.07.2021.
//

import UIKit

class SubheadlineTitleLabel: UILabel {
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        configure(fontSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(fontSize: CGFloat) {
        font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        textAlignment = .center
        textColor = UIColor.black
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        numberOfLines = 2
    }
}

