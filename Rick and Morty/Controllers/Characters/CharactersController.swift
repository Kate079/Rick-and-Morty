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
    var hasNextPage = true
    var nextPage = 2
    var searchTask: DispatchWorkItem?
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarText: String {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return "" }
        return text
    }
    
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
            configureNavigationBar()
            configureCollectionView()
            configureSearchController()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .customGray
    }
    
    private func configureNavigationBar() {
        navigationItem.titleView = HeadlineTitleLabel(text: "Characters")
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .customGreen
        let rightBarButton = UIButton()
        rightBarButton.setImage(Images.filterImage, for: .normal)
        rightBarButton.addTarget(self, action: #selector(filter), for: .touchUpInside)
        rightBarButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightBarButton.heightAnchor.constraint(equalToConstant: 30),
            rightBarButton.widthAnchor.constraint(equalTo: rightBarButton.heightAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    @objc private func filter() {
        Alert.showAlert(on: self, title: "Something Went Wrong", message: "Sorry, this feature is currently unavailable")
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
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.isHidden = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
