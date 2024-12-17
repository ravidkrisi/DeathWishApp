//
//  UsersManager.swift
//  DeathWish
//
//  Created by Ravid Krisi on 13/12/2024.
//

import Foundation
import FirebaseFirestore



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
