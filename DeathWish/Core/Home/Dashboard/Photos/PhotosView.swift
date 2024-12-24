//
//  PhotosView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 23/12/2024.
//

import SwiftUI

@MainActor
final class PhotosViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    
    func getPhotos(userId: String) {
        Task {
            self.photos = try await PhotosManager.shared.getPhotos(userId: userId)
        }
    }
}
struct PhotosView: View {
    
    @StateObject var vm = PhotosViewModel()
    @Binding var currUser: DBUser?
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 20
    let rowNumItems: CGFloat = 2
    
    var itemSize: CGFloat {
        let totalSpacing = (horizontalPadding * 2) + ((rowNumItems-1) * spacing)
        let availableSpace = UIScreen.main.bounds.width - totalSpacing
        return availableSpace / rowNumItems
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [
                GridItem(.fixed(itemSize), spacing: spacing),
                GridItem(.fixed(itemSize), spacing: spacing)
            ]
                      , spacing: spacing) {
                
                ForEach(vm.photos) { photo in
                    PhotoGridItemView(photo: photo, size: itemSize)
                }
            }
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
        .onAppear {
            guard let userId = currUser?.id else { return }
            vm.getPhotos(userId: userId)
        }
    }
}

#Preview {
    NavigationStack {
        PhotosView(currUser: .constant(DBUser.example))
    }
}
