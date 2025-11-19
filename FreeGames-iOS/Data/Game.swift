//
//  Game.swift
//  FreeGames-iOS
//
//  Created by Mananas on 12/11/25.
//

import Foundation

struct Game: Codable {
    let id: Int
    let title: String
    let thumbnail: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let descriptionShort: String
    let description: String?
    let profileUrl: String
    let gameUrl: String
    let minSystemRequirements: MinimumSystemRequirements?
    var screenshots: [Screenshot]?
    
    enum CodingKeys: String, CodingKey {
        case descriptionShort = "short_description"
        case profileUrl = "freetogame_profile_url"
        case gameUrl = "game_url"
        case minSystemRequirements = "minimum_system_requirements"
        case id, title, thumbnail, genre, platform, publisher, developer, description, screenshots
    }
}

struct MinimumSystemRequirements: Codable {
    let os: String
    let processor: String
    let memory: String
    let graphics: String
    let storage: String
}

struct Screenshot: Codable {
    let image: String
}
