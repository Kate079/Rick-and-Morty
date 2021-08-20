//
//  NetworkManager.swift
//  Rick and Morty
//
//  Created by Kate on 21.07.2021.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let session = URLSession.shared
    private let baseURL = "https://rickandmortyapi.com/api"
    private let cache = NSCache<NSString, UIImage>()
    
    func getCharacters(page: Int, name: String, completionHandler: @escaping (Result<CharactersResponse, Errors>) -> Void) {
        let endpoint = baseURL + "/character?page=\(page)&name=\(name)"
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.URLError))
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }
            do {
                let characters = try JSONDecoder().decode(CharactersResponse.self, from: data)
                completionHandler(.success(characters))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    func getCharactersImages(urlString: String, completionHandler: @escaping (Result<UIImage, Errors>) -> Void) {
        if let image = cache.object(forKey: NSString(string: urlString)) {
            completionHandler(.success(image))
            return
        }
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.URLError))
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.dataError))
                return
            }
            self.cache.setObject(image, forKey: NSString(string: urlString))
            completionHandler(.success(image))
            }
        task.resume()
    }
    
    func getLocations(page: Int, completionHandler: @escaping (Result<LocationsResponse, Errors>) -> Void) {
        let endpoint = baseURL + "/location?page=\(page)"
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.URLError))
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }
            do {
                let locations = try JSONDecoder().decode(LocationsResponse.self, from: data)
                print(locations)
                completionHandler(.success(locations))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    func getEpisodes(page: Int, completionHandler: @escaping (Result<EpisodesResponse, Errors>) -> Void) {
        let endpoint = baseURL + "/episode?page=\(page)"
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.URLError))
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }
            do {
                let episodes = try JSONDecoder().decode(EpisodesResponse.self, from: data)
                print(episodes)
                completionHandler(.success(episodes))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }
        task.resume()
    }
}
