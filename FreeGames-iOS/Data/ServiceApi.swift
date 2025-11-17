//
//  ServiceApi.swift
//  FreeGames-iOS
//
//  Created by Mananas on 12/11/25.
//

import Foundation

class ServiceApi {
    
    static let SERVER_BASE_URL = "https://www.freetogame.com/api/"
    
    func getAllGames() async -> [Game] {
        guard let url = URL(string: ServiceApi.SERVER_BASE_URL + "games") else {
            print("Could not create URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let gameList = try JSONDecoder().decode([Game].self, from: data)
            
            /*if let str = String(data: data, encoding: .utf8) {
                print("Successfully decoded: \(str)")
            }*/
            return gameList
        } catch {
            print(error)
            return []
        }
    }
    
    func getGameById(id: Int) async -> Game? {
        guard let url = URL(string: ServiceApi.SERVER_BASE_URL + "game?id=\(id)") else {
            print("Could not create URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let game = try JSONDecoder().decode(Game.self, from: data)
            
            /*if let str = String(data: data, encoding: .utf8) {
                print("Successfully decoded: \(str)")
            }*/
            return game
        } catch {
            print(error)
            return nil
        }
    }
}
