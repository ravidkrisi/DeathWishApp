//
//  DashboardView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 16/12/2024.
//

import SwiftUI


struct DashboardView: View {
    @Binding var currUser: DBUser?
    @Binding var showSignInView: Bool
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 20
    let rowNumItems: CGFloat = 2
    
    var itemSize: CGFloat {
        let totalSpacing = (horizontalPadding * 2) + ((rowNumItems-1) * spacing)
        let availableSpace = UIScreen.main.bounds.width - totalSpacing
        return availableSpace / rowNumItems
    }
    
    var body: some View {
        homeGrid
    }
}

#Preview {
    NavigationStack {
        DashboardView(currUser: .constant(DBUser.example), showSignInView: .constant(true))
    }
}

extension DashboardView {
    var homeGrid: some View {
        VStack {
            if let currUser {
                Text (currUser.id)
            }
            Button("Log Out") {
                try? AuthenticationManager.shared.signOut()
                self.currUser = nil
                self.showSignInView = true
            }
            
            Button("test storage") {
                Task {
                    guard let user = currUser else { return }
                    let note = Note(title: "test", body: "testbody")
                    
                    try await NotesManager.shared.saveNote(userId: user.id, note: note)
                    print("saved note to DB and storage")
                }
            }
            LazyVGrid(columns: [
                GridItem(.fixed(itemSize), spacing: spacing),
                GridItem(.fixed(itemSize), spacing: spacing)
            ]
                      , spacing: spacing) {
                NavigationLink {
                    FavoriteSongsView(currUser: $currUser)
                } label: {
                    DashboardItemView(title: "Favorite Songs", size: itemSize)
                }

            }
        }
    }
}
