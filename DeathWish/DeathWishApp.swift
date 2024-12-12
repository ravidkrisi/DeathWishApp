//
//  DeathWishApp.swift
//  DeathWish
//
//  Created by Ravid Krisi on 11/12/2024.
//

import SwiftUI
import Firebase

@main
struct DeathWishApp: App {
    
    init() {
        FirebaseApp.configure()
        print("configured firebase")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
    }
}
