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
    var body: String?
    let bodyPath: String?
    
    init(title: String, body: String? = nil, bodyPath: String? = nil) {
        self.title = title
        self.body = body
        self.bodyPath = bodyPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case bodyPath = "body_path"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.bodyPath = try container.decodeIfPresent(String.self, forKey: .bodyPath)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.body, forKey: .body)
        try container.encode(self.bodyPath, forKey: .bodyPath)
    }
    
    static let example = Note(title: "title example", body: "body example", bodyPath: "fake path")
}
