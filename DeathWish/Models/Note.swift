//
//  Note.swift
//  DeathWish
//
//  Created by Ravid Krisi on 21/12/2024.
//

import Foundation

struct Note: Identifiable, Codable {
    let id = UUID().uuidString
    let title: String
    let body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case body
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.body, forKey: .body)
    }
}
