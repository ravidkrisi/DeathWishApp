//
//  PhotosView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 23/12/2024.
//

import SwiftUI

struct PhotosView: View {
    
    @Binding var currUser: DBUser?
    
    var body: some View {
        VStack {
            
        }
        .navigationTitle("Photos")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddPhotosView(currUser: $currUser)
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

#Preview {
    NavigationStack {
        PhotosView(currUser: .constant(DBUser.example))
    }
}
