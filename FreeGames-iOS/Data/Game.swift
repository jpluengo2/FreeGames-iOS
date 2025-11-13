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
}
