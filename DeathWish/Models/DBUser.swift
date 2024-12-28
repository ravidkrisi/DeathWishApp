//
//  DBUser.swift
//  DeathWish
//
//  Created by Ravid Krisi on 17/12/2024.
//

import Foundation

struct DBUser: Codable, Identifiable {
    let id: String
    let name: String?
    let email: String?
    let dateOfBirth: Date?
    let dateCreated: Date?
    let profilePicPath: String?
    
    init(id: String, name: String? = nil, email: String? = nil, dateOfBirth: Date? = nil, profilePicPath: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.dateCreated = .now
        self.profilePicPath = profilePicPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case dateOfBirth = "date_of_birth"
        case dateCreated = "date_created"
        case profilePicPath = "profile_pic_path"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.dateOfBirth = try container.decodeIfPresent(Date.self, forKey: .dateOfBirth)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.profilePicPath = try container.decodeIfPresent(String.self, forKey: .profilePicPath)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.profilePicPath, forKey: .profilePicPath)
    }
    
    static let example = DBUser(id: "3Wln2oZYcDZUpQkZDL7NRZnxZMk1", name: "example example", email: "example@example.com", dateOfBirth: .now)
}
