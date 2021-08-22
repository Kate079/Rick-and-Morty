//
//  CharacterInfoController.swift
//  Rick and Morty
//
//  Created by Kate on 11.08.2021.
//

import UIKit

class CharacterInfoController: UIViewController {
    private var characters: Characters
    private let imageView = CharactersImageView()
    private let nameLabel = NormalTextLabel()
    private let statusLabel = NormalTextLabel()
    private let speciesLabel = NormalTextLabel()
    private let genderLabel = NormalTextLabel()
    private let locationLabel = NormalTextLabel()
    private let stringAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.customGreen]
    private lazy var stackView = StackView(arrangedSubviews: [nameLabel, statusLabel, speciesLabel, genderLabel, locationLabel])
    
    init(characters: Characters) {
        self.characters = characters
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        configureUI()
    }
    
    private func setData() {
        navigationItem.titleView = HeadlineTitleLabel(text: characters.name)
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
        
        let nameAttributedString = NSMutableAttributedString(string: "Name:   ", attributes: stringAttributes)
        nameAttributedString.append(NSMutableAttributedString(string: characters.name))
        nameLabel.attributedText = nameAttributedString
        
        let statusAttributedString = NSMutableAttributedString(string: "Status:   ", attributes: stringAttributes)
        statusAttributedString.append(NSMutableAttributedString(string: characters.status))
        statusLabel.attributedText = statusAttributedString
        
        let speciesAttributedString = NSMutableAttributedString(string: "Species:   ", attributes: stringAttributes)
        speciesAttributedString.append(NSMutableAttributedString(string: characters.species))
        speciesLabel.attributedText = speciesAttributedString
        
        let genderAttributedString = NSMutableAttributedString(string: "Gender:   ", attributes: stringAttributes)
        genderAttributedString.append(NSMutableAttributedString(string: characters.gender))
        genderLabel.attributedText = genderAttributedString
        
        let locationAttributedString = NSMutableAttributedString(string: "Location:   ", attributes: stringAttributes)
        locationAttributedString.append(NSMutableAttributedString(string: characters.location))
        locationLabel.attributedText = locationAttributedString
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor.customGray
        view.addSubview(imageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
