//
//  CharactersImageView.swift
//  Rick and Morty
//
//  Created by Kate on 03.08.2021.
//

import UIKit

class CharactersImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.cornerRadius = 16.0
        clipsToBounds = true
        image = Images.charactersLogo
    }
}
