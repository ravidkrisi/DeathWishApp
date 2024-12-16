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
        Text("hello")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(showSignInView: .constant(true))
}
