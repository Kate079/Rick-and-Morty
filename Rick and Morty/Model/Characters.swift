//
//  Characters.swift
//  Rick and Morty
//
//  Created by Kate on 28.07.2021.
//

import Foundation

struct CharactersResponse: Decodable {
    var nextPage: String?
    var previousPage: String?
    var results: [Characters]

    private enum CharactersResponseKeys: String, CodingKey {
        case info
        case results
    }

    private enum InfoKeys: String, CodingKey {
        case nextPage = "next"
        case previousPage = "prev"
    }

    init(from decoder: Decoder) throws {
        let charactersResponseContainer = try decoder.container(keyedBy: CharactersResponseKeys.self)
        results = try charactersResponseContainer.decode([Characters].self, forKey: CharactersResponseKeys.results)
        let infoContainer = try charactersResponseContainer.nestedContainer(keyedBy: InfoKeys.self, forKey: .info)
        nextPage = try infoContainer.decode(String?.self, forKey: .nextPage)
        previousPage = try infoContainer.decode(String?.self, forKey: .previousPage)
    }
}

struct Characters: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: String
    let image: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case location
        case image
    }

    private enum LocationCodingKeys: String, CodingKey {
          case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        gender = try container.decode(String.self, forKey: .gender)

        let locationName = try container.nestedContainer(keyedBy: LocationCodingKeys.self, forKey: .location)
        location = try locationName.decode(String.self, forKey: .name)

        image = try container.decode(String.self, forKey: .image)
    }
}

extension Characters: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Characters, rhs: Characters) -> Bool {
        lhs.id == rhs.id
    }
}
