//
//  HomeView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 13/12/2024.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @Binding var showSignInView: Bool
    @Binding var currUser: DBUser?
   
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                DashboardView(currUser: $currUser, showSignInView: $showSignInView)
            }
            
            Tab("Profile", systemImage: "person") {
                ProfileView(currUser: $currUser, showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(showSignInView: .constant(true), currUser: .constant(DBUser.example))
    }
}
