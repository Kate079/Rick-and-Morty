//
//  SectionsViewController.swift
//  Rick and Morty
//
//  Created by Kate on 21.07.2021.
//

import UIKit

class SectionsViewController: UIViewController {
    let sections = [
        SectionsList(title: "Characters", backgroundImage: Images.charactersLogo),
        SectionsList(title: "Locations", backgroundImage: Images.locationsLogo),
        SectionsList(title: "Episodes", backgroundImage: Images.episodesLogo)
    ]
    
    private var collectionView: UICollectionView!
    private let sectionNameLabel = HeadlineTitleLabel(text: "Choose section")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .customGray
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .customGreen
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.backButtonTitle = ""
        view.addSubview(sectionNameLabel)
        
        NSLayoutConstraint.activate([
            sectionNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sectionNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sectionNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sectionNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SectionsCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: sectionNameLabel.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
