//
//  SectionsCell.swift
//  Rick and Morty
//
//  Created by Kate on 23.07.2021.
//

import UIKit

class SectionsCell: UICollectionViewCell {
    var data: SectionsList? {
        didSet {
            guard let data = data else { return }
            backgroundImageView.image = data.backgroundImage
            sectionLabel.text = data.title
        }
    }
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.alpha = 0.5
        return imageView
    }()
    
    private let backgroundColorView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.systemGray2.cgColor
        return imageView
    }()
    
    private let sectionLabel = SubheadlineTitleLabel(fontSize: 24)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(backgroundColorView)
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(sectionLabel)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            backgroundColorView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            backgroundColorView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            backgroundColorView.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor),
            backgroundColorView.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor),
            
            sectionLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            sectionLabel.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            sectionLabel.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor),
            sectionLabel.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor)
        ])
    }
}
