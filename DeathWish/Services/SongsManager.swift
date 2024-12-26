//
//  SongsManager.swift
//  DeathWish
//
//  Created by Ravid Krisi on 17/12/2024.
//

import Foundation
import FirebaseFirestore

class SongsManager {
    
    static let shared = SongsManager()
    private init() { }
    
    private var listener: ListenerRegistration? = nil
    
    private func userMusicDoc(userId: String) -> CollectionReference {
        UsersManager.shared.userDoc(userId: userId).collection("favorite_music")
    }
    
    func addSongToDB(song: Song, userId: String) async throws {
        try userMusicDoc(userId: userId).document(song.id).setData(from: song)
    }
    
    func getUsersFavoriteSongs(userId: String) async throws -> [Song] {
        let musicRef = userMusicDoc(userId: userId)
        
        let songs: [Song] = try await Firestore.firestore().getCollectionDocs(collectionRef: musicRef)
        return songs
    }
    
    func listenToUsersFavoriteSongs(userId: String, onUpdate: @escaping ([Song]) -> Void) {
            let musicRef = userMusicDoc(userId: userId)
            
            listener = musicRef.addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error listening to songs: \(error)")
                    return
                }
                
                let songs = snapshot?.documents.compactMap { document in
                    try? document.data(as: Song.self)
                } ?? []
                
                DispatchQueue.main.async {
                    onUpdate(songs)
                }
            }
    }
    
    func stopListening() {
            listener?.remove()
            listener = nil
    }
}
