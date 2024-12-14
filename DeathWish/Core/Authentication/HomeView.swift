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
    var body: some View {
        VStack {
            Button {
                Task {
                    try Auth.auth().signOut()
                    showSignInView = true
                }
            } label: {
                Text("sign out")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(showSignInView: .constant(true))
}
