//
//  HomeView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 13/12/2024.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    enum Tabs: String {
        case home = "Home"
        case profile = "Profile"
    }
    
    @Binding var showSignInView: Bool
    @Binding var currUser: DBUser?
   
    @State private var selectedTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView(currUser: $currUser, showSignInView: $showSignInView)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tabs.home)

            ProfileView(currUser: $currUser, showSignInView: $showSignInView)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tabs.profile)
            }
        .navigationTitle(selectedTab.rawValue)
        }
}

#Preview {
    NavigationStack {
        HomeView(showSignInView: .constant(true), currUser: .constant(DBUser.example))
    }
}
