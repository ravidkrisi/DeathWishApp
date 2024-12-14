//
//  UsersManager.swift
//  DeathWish
//
//  Created by Ravid Krisi on 13/12/2024.
//

import Foundation
import FirebaseFirestore

struct DBUser: Codable, Identifiable {
    let id: String
    let name: String?
    let email: String?
    let dateOfBirth: Date?
    let dateCreated: Date?
    
    init(id: String, name: String?, email: String?, dateOfBirth: Date?) {
        self.id = id
        self.name = name
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.dateCreated = .now
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case dateOfBirth = "date_of_birth"
        case dateCreated = "date_created"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.dateOfBirth = try container.decodeIfPresent(Date.self, forKey: .dateOfBirth)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
    }
}

final class UsersManager {
    
    static let shared = UsersManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDoc(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func addUser(user: DBUser) async throws {
        try userDoc(userId: user.id).setData(from: user)
    }
}
