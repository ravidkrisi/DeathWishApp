//
//  PhotosManager.swift
//  DeathWish
//
//  Created by Ravid Krisi on 23/12/2024.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

final class PhotosManager {
    
    static let shared = PhotosManager()
    private init() { }
    
    func savePhoto(userId: String, photo: Photo) async throws {
        // save image to storage
        guard let metaData = try await saveImageToStorage(userId: userId, photo: photo) else { return }
        
        guard let imagePath = metaData.path else { return }
        
        // save photo to DB
        try await savePhotoToDB(userId: userId, photo: photo, photoPath: imagePath)
        
    }
    
    private func savePhotoToDB(userId: String, photo: Photo, photoPath: String) async throws {
        let userPhotosCollection = UsersManager.shared.userDoc(userId: userId).collection("photos")
        
        let data: [String: Any] = [
            "id" : photo.id,
            "caption" : photo.caption,
            "image_path" : photoPath
        ]
        
        try await userPhotosCollection.document(photo.id).setData(data)
    }
    
    private func saveImageToStorage(userId: String, photo: Photo) async throws -> StorageMetadata? {
        let fileRef = Storage.storage().usersRef.child("\(userId)/photos/\(photo.id).jpeg")
        guard let data = photo.image else { return nil }
        
        return try await fileRef.putDataAsync(data)
    }
    
    // GET Photos
    func downloadImage(imagePath: String) async throws -> UIImage? {
        guard let data = try await  Storage.storage().downloadFile(filePath: imagePath) else { return nil }
        
        return UIImage(data: data)
    }
    
    
    func getPhotos(userId: String) async throws -> [Photo] {
        let usersPhotoCollection = UsersManager.shared.userDoc(userId: userId).collection("photos")
        
        let photos: [Photo] = try await Firestore.firestore().getCollectionDocs(collectionRef: usersPhotoCollection)
        
        return photos
    }
}
