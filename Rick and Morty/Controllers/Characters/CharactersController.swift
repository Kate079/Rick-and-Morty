//
//  CharactersController.swift
//  Rick and Morty
//
//  Created by Kate on 31.07.2021.
//

import UIKit

class CharactersController: UIViewController {
    var characters: CharactersResponse
    var collectionView: UICollectionView!
    var searchController: UISearchController!
    var hasNextPage = true
    var nextPage = 2
        
    init(characters: CharactersResponse) {
        self.characters = characters
        super.init(nibName: nil, bundle: nil)
        
        guard characters.nextPage != nil else {
            hasNextPage = false
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if characters.results.isEmpty {
            view.addSubview(EmptyStateView(frame: view.bounds))
        } else {
            configureUI()
            configureCollectionView()
            configureSearchController()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor.customGray
        
        navigationItem.titleView = HeadlineTitleLabel(text: "Characters")
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.customGreen
        let filterImage = Images.filterImage?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterImage, style: .plain, target: nil, action: nil)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterDataCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureSearchController() {
        searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = ""
        searchController.searchBar.isHidden = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
