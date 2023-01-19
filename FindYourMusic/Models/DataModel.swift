//
//  DataModel.swift
//  FindYourMusic
//
//  Created by Irakli Nozadze on 18.01.23.
//

import Foundation

class DataModel {
    private var dataTask: URLSessionDataTask?
    
    func loadSongs(searchTerm: String, completion: @escaping(([Song]) -> Void)) {
        dataTask?.cancel()
        
        guard let url = buildUrl(fromTerm: searchTerm) else {
            completion([])
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            if let songRespose = try? JSONDecoder().decode(SongResponse.self, from: data) {
                completion(songRespose.songs)
            }
        }
        dataTask?.resume()
    }
    
    private func buildUrl(fromTerm searchTerm: String) -> URL? {
        guard !searchTerm.isEmpty else { return nil }
        
        let queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: "song")
        ]
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        components?.queryItems = queryItems
        
        return components?.url
    }
}

struct SongResponse: Decodable {
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case songs = "results"
    }
}

struct Song: Decodable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case artworkUrl = "artworkUrl60"
    }
}
