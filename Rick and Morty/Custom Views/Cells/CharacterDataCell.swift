//
//  CharacterDataCell.swift
//  Rick and Morty
//
//  Created by Kate on 02.08.2021.
//

import UIKit

class CharacterDataCell: UICollectionViewCell {
    private let imageView = CharactersImageView()
    private let titleLabel = SubheadlineTitleLabel(fontSize: 18)
    
    private let backgroundLabelColorView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.backgroundColor = .white
        imageView.alpha = 0.5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(characters: Characters) {
        titleLabel.text = characters.name
        NetworkManager.shared.getCharactersImages(urlString: characters.image) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            case .failure:
                break
            }
        }
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(backgroundLabelColorView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            backgroundLabelColorView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.25),
            backgroundLabelColorView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            backgroundLabelColorView.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            backgroundLabelColorView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: backgroundLabelColorView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundLabelColorView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: backgroundLabelColorView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: backgroundLabelColorView.rightAnchor)
        ])
    }
}
