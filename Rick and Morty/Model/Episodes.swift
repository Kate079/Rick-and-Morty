//
//  Episodes.swift
//  Rick and Morty
//
//  Created by Kate on 01.08.2021.
//

import Foundation

struct EpisodesResponse: Decodable {
    var nextPage: String?
    var previousPage: String?
    var results: [Episodes]
    
    private enum EpisodesResponseKeys: String, CodingKey {
        case info
        case results
    }

    private enum InfoKeys: String, CodingKey {
        case nextPage = "next"
        case previousPage = "prev"
    }
    
    init(from decoder: Decoder) throws {
        let episodesResponseContainer = try decoder.container(keyedBy: EpisodesResponseKeys.self)
        results = try episodesResponseContainer.decode([Episodes].self, forKey: EpisodesResponseKeys.results)
        let infoContainer = try episodesResponseContainer.nestedContainer(keyedBy: InfoKeys.self, forKey: .info)
        nextPage = try infoContainer.decode(String?.self, forKey: .nextPage)
        previousPage = try infoContainer.decode(String?.self, forKey: .previousPage)
    }
}

struct Episodes: Decodable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
    }
}
