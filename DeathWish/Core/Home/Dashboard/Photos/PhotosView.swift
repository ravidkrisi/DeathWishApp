//
//  PhotosView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 23/12/2024.
//

import SwiftUI
import PhotosUI

final class PhotosViewModel: ObservableObject {
    
    @Published var selectedPhoto: PhotosPickerItem? = nil {
        didSet {
            Task {
                if let selectedPhoto,
                   let data = try await selectedPhoto.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    self.image = image
                }
                print("im here")
            }
        }
    }
    @Published var image: UIImage?
    
}

struct PhotosView: View {
    
    @StateObject var vm = PhotosViewModel()
    
    @Binding var currUser: DBUser?
    
    var body: some View {
        VStack {
            PhotosPicker("pick a photo", selection: $vm.selectedPhoto)
            
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .navigationTitle("Photos")
    }
}

#Preview {
    NavigationStack {
        PhotosView(currUser: .constant(DBUser.example))
    }
}
