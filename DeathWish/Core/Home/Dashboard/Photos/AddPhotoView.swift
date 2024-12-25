//
//  PhotosView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 23/12/2024.
//

import SwiftUI
import PhotosUI

final class AddPhotosViewModel: ObservableObject {
    
    @Published var selectedPhoto: PhotosPickerItem? = nil {
        didSet {
            Task {
                if let selectedPhoto,
                   let data = try await selectedPhoto.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    await MainActor.run {
                        self.image = image
                    }
                }
            }
        }
    }
    @Published var image: UIImage?
    @Published var caption: String = ""
    
    func savePhoto(userId: String) {
        Task {
            guard let image,
                  let data = image.jpegData(compressionQuality: 1.0) else { return }
            let photo = Photo(caption: "test", image: data)
            try await PhotosManager.shared.savePhoto(userId: userId, photo: photo)
            print("saved photo successfully")
        }
    }
}

struct AddPhotosView: View {
    
    @StateObject var vm = AddPhotosViewModel()
    @Binding var currUser: DBUser?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $vm.selectedPhoto) {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                } else {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Select Photo")
                    }
                }
            }
            
            TextField("caption", text: $vm.caption)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
        .navigationTitle("Add Photo")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    guard let currUser else { return }
                    vm.savePhoto(userId: currUser.id)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddPhotosView(currUser: .constant(DBUser.example))
    }
}
