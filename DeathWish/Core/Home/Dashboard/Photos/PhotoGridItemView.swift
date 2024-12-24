//
//  PhotoGridItemView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 24/12/2024.
//
import SwiftUI

@MainActor
final class PhotoGridItemViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    
    func getImage(imagePath: String) {
        Task {
            self.image = try await PhotosManager.shared.downloadImage(imagePath: imagePath)
        }
    }
}

struct PhotoGridItemView: View {
    @StateObject var vm = PhotoGridItemViewModel()
    let photo: Photo
    let size: CGFloat
    
    var body: some View {
        ZStack { // Ensures layering
            if let image = vm.image {
                VStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Divider()
                    Text(photo.caption)
                        .font(.caption)
                }
                .padding(3)
            } else {
                ProgressView()
                    .frame(width: size, height: size)
            }
            
            RoundedRectangle(cornerRadius: 10) // Always on top
                .stroke(Color.gray.opacity(0.2), lineWidth: 3)
        }
        .frame(width: size, height: size)
        .onAppear {
            vm.getImage(imagePath: photo.imagePath ?? "")
        }
    }
}

#Preview {
    PhotoGridItemView(photo: Photo.example, size: 150)
}
