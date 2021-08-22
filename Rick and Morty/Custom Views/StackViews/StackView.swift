//
//  StackView.swift
//  Rick and Morty
//
//  Created by Kate on 12.08.2021.
//

import UIKit

class StackView: UIStackView {
    init(arrangedSubviews: [UIView]) {
        super.init(frame: .zero)
        configure(arrangedSubviews: arrangedSubviews)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(arrangedSubviews: [UIView]) {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .leading
        distribution = .fill
        spacing = 20.0
        arrangedSubviews.forEach { addArrangedSubview($0) }
    }
}
