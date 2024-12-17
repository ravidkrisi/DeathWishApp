//
//  Song.swift
//  DeathWish
//
//  Created by Ravid Krisi on 17/12/2024.
//

import Foundation

struct Song: Codable, Identifiable {
    let id: String
    let title: String
    let artist: String
    let album: String
    
    init(title: String, artist: String, album: String) {
        self.id = UUID().uuidString
        self.title = title
        self.artist = artist
        self.album = album
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case artist
        case album
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.artist, forKey: .artist)
        try container.encode(self.album, forKey: .album)
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.album = try container.decode(String.self, forKey: .album)
    }
}
