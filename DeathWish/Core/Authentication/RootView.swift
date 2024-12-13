//
//  RootView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 12/12/2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if showSignInView {
                SignInView(showSignInView: $showSignInView)
            } else {
                HomeView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            if let user = AuthenticationManager.shared.getCurrentUser() {
                showSignInView = false
            } else {
                showSignInView = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        RootView()
    }
}
