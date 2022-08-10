//
//  IncorrectDisneyCharacter.swift
//  DisneyPediaTests
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import Foundation

struct IncorrectDisneyCharacter: Decodable {
    let id: Int64
    let imageUrl: String
    let name: String
    let url: String
    let enemies: [String]
    let allies: [String]
    let parkAttractions: [String]
    let videoGames: [String]
    let tvShows: [String]
    let shortFilm: [String]
    let films: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case imageUrl
        case url
        case enemies
        case allies
        case parkAttractions
        case videoGames
        case tvShows
        case shortFilm
        case films
    }
}
