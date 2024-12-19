//
//  RootView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 12/12/2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = true
    
    @State var currUser: DBUser? = nil
    
    var body: some View {
        ZStack {
            if showSignInView {
                SignInView(showSignInView: $showSignInView, currUser: $currUser)
            } else {
//                DashboardView(currUser: $currUser, showSignInView: $showSignInView)
                FavoriteSongsView(currUser: $currUser)
            }
        }
        .onAppear {
            Task {
                if let authResult = AuthenticationManager.shared.getCurrentUser() {
                    if let user = try await UsersManager.shared.getUser(userId: authResult.uid) {
                        self.currUser = user
                        showSignInView = false
                    }
                } else {
                    showSignInView = true
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RootView()
    }
}
