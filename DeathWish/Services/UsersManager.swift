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
