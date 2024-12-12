//
//  AuthenticationManager.swift
//  DeathWish
//
//  Created by Ravid Krisi on 12/12/2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResult {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

final class AuthenticationManager {
    
    static var shared = AuthenticationManager()
    private init() { }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResult? {
        let reuslt = try await Auth.auth().createUser(withEmail: email, password: password)
        print("created new user successfully")
        return AuthDataResult(user: reuslt.user)
    }
    
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResult? {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResult(user: result.user)
    }
    
    func getCurrentUser() -> AuthDataResult? {
        guard let user = Auth.auth().currentUser else { return nil }
        return AuthDataResult(user: user)
    }
}
