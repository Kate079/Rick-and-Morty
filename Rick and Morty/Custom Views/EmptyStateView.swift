//
//  EmptyStateView.swift
//  Rick and Morty
//
//  Created by Kate on 21.07.2021.
//

import UIKit

class EmptyStateView: UIView {
    private let messageLabel = HeadlineTitleLabel(text: "Look, Morty! \n There's nothing there!")
    private let emptyStateLogo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .customGray
        messageLabel.numberOfLines = 2
        emptyStateLogo.image = Images.emptyStateLogo
        emptyStateLogo.contentMode = .scaleAspectFit
        emptyStateLogo.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(emptyStateLogo)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            emptyStateLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emptyStateLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            emptyStateLogo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            emptyStateLogo.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -(self.frame.height * 0.4)),
            
            messageLabel.topAnchor.constraint(equalTo: emptyStateLogo.bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: emptyStateLogo.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: emptyStateLogo.trailingAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
