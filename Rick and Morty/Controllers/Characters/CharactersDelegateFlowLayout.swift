//
//  CharactersDelegateFlowLayout.swift
//  Rick and Morty
//
//  Created by Kate on 02.08.2021.
//

import UIKit

extension CharactersController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = view.frame.width / 2.4
        let itemHeight = itemWidth * 1.2
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterDataCell
        cell.setData(characters: characters.results[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterInfoController = CharacterInfoController(characters: characters.results[indexPath.row])
        navigationController?.pushViewController(characterInfoController, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasNextPage else {
            return
        }
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewFrameHeight = scrollView.frame.size.height
        
        if (position + scrollViewFrameHeight) > contentHeight {
            NetworkManager.shared.getCharacters(page: nextPage, name: searchBarText) { [weak self] result in
                switch result {
                case .success(let newData):
                    self?.characters.results.append(contentsOf: newData.results)
                    self?.nextPage += 1
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure:
                    break
                }
            }
        }
    }
}

extension CharactersController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            NetworkManager.shared.getCharacters(page: 1, name: "") { [weak self] result in
                switch result {
                case .success(let newData):
                    self?.characters.results = newData.results
                    self?.nextPage = 2
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure:
                    break
                }
            }
            return
        }
        searchTask?.cancel()
        nextPage = 2
        let task = DispatchWorkItem {
            DispatchQueue.global(qos: .userInteractive).async {
                NetworkManager.shared.getCharacters(page: 1, name: searchText) { [weak self] result in
                    switch result {
                    case .success(let newData):
                        self?.characters.results = newData.results
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                    case .failure:
                        self?.characters.results = []
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                    }
                }
            }
        }
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        NetworkManager.shared.getCharacters(page: 1, name: "") { [weak self] result in
            switch result {
            case .success(let newData):
                self?.characters.results = newData.results
                self?.nextPage = 2
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure:
                break
            }
        }
    }
}
