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
            LazyVGrid(columns: [
                GridItem(.fixed(itemSize), spacing: spacing),
                GridItem(.fixed(itemSize), spacing: spacing)
            ]
                      , spacing: spacing) {
                
                // favorite songs
                NavigationLink {
                    FavoriteSongsView(currUser: $currUser)
                } label: {
                    DashboardItemView(title: "Favorite Songs", size: itemSize)
                }

                // notes
                NavigationLink {
                    NotesView(currUser: $currUser)
                } label: {
                    DashboardItemView(title: "notes", size: itemSize)
                }
                
                // photos
                NavigationLink {
                    PhotosView(currUser: $currUser)
                } label: {
                    DashboardItemView(title: "photos", size: itemSize)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
