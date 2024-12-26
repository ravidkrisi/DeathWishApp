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
        
        self.listener = Firestore.firestore().listenToCollection(userId: userId, collectionRef: musicRef, onUpdate: onUpdate)
    }
    
    func stopListening() {
            listener?.remove()
            listener = nil
    }
}
