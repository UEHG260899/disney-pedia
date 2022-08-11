//
//  DisneyCharacter.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import Foundation

struct DisneyCharacter: Decodable {
    let id: Int64
    let imageUrl: String?
    let name: String
    let url: String
    let enemies: [String]
    let allies: [String]
    let parkAttractions: [String]
    let videoGames: [String]
    let tvShows: [String]
    let shortFilms: [String]
    let films: [String]
    
    static var mock: DisneyCharacter {
        DisneyCharacter(id: 0,
                        imageUrl: "",
                        name: "",
                        url: "",
                        enemies: [],
                        allies: [],
                        parkAttractions: [],
                        videoGames: [],
                        tvShows: [],
                        shortFilms: [],
                        films: [])
    }
    
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
        case shortFilms
        case films
    }
}
