//
//  Locations.swift
//  Rick and Morty
//
//  Created by Kate on 01.08.2021.
//

import Foundation

struct LocationsResponse: Decodable {
    var nextPage: String?
    var previousPage: String?
    var results: [Locations]
    
    private enum LocationsResponseKeys: String, CodingKey {
        case info
        case results
    }
    
    private enum InfoKeys: String, CodingKey {
        case nextPage = "next"
        case previousPage = "prev"
    }
    
    init(from decoder: Decoder) throws {
        let locationsResponseContainer = try decoder.container(keyedBy: LocationsResponseKeys.self)
        results = try locationsResponseContainer.decode([Locations].self, forKey: LocationsResponseKeys.results)
        let infoContainer = try locationsResponseContainer.nestedContainer(keyedBy: InfoKeys.self, forKey: .info)
        nextPage = try infoContainer.decode(String?.self, forKey: .nextPage)
        previousPage = try infoContainer.decode(String?.self, forKey: .previousPage)
    }
}

struct Locations: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case dimension
    }
}
