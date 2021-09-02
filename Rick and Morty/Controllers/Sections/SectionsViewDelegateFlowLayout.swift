//
//  SectionsViewDelegateFlowLayout.swift
//  Rick and Morty
//
//  Created by Kate on 23.07.2021.
//

import UIKit

extension SectionsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SectionsCell
        cell.data = sections[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let loadingViewController = LoadingViewController()
        present(loadingViewController, animated: true)
        
        let currentItem = sections[indexPath.item]
        switch currentItem.title {
        case "Characters":
            NetworkManager.shared.getCharacters(page: 1, name: "") { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let characters):
                    DispatchQueue.main.async {
                        loadingViewController.dismiss(animated: true) {
                            let charactersController = CharactersController(characters: characters)
                            self.navigationController?.pushViewController(charactersController, animated: true)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        loadingViewController.dismiss(animated: true) {
                            Alert.showAlert(on: self, title: "Something Went Wrong", message: error.rawValue)
                        }
                    }
                }
            }
        case "Locations":
            NetworkManager.shared.getLocations(page: 1) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        loadingViewController.dismiss(animated: true) {
                            let emptyStateViewController = UIViewController()
                            emptyStateViewController.view.addSubview(EmptyStateView(frame: emptyStateViewController.view.bounds))
                            self.navigationController?.pushViewController(emptyStateViewController, animated: true)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        loadingViewController.dismiss(animated: true) {
                            Alert.showAlert(on: self, title: "Something Went Wrong", message: error.rawValue)
                        }
                    }
                }
            }
        case "Episodes":
            NetworkManager.shared.getEpisodes(page: 1) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        loadingViewController.dismiss(animated: true) {
                            let emptyStateViewController = UIViewController()
                            emptyStateViewController.view.addSubview(EmptyStateView(frame: emptyStateViewController.view.bounds))
                            self.navigationController?.pushViewController(emptyStateViewController, animated: true)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        loadingViewController.dismiss(animated: true) {
                            Alert.showAlert(on: self, title: "Something Went Wrong", message: error.rawValue)
                        }
                    }
                }
            }
        default:
            break
        }
    }
}
