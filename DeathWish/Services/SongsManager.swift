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
    
    private func userMusicDoc(userId: String) -> CollectionReference {
        UsersManager.shared.userDoc(userId: userId).collection("favorite_music")
    }
    
    func addSongToDB(song: Song, userId: String) async throws {
        try userMusicDoc(userId: userId).document(song.id).setData(from: song)
    }
    
    func getUsersFavoriteSongs(userId: String) async throws -> [Song] {
        let querySnapshot = try await userMusicDoc(userId: userId).getDocuments()
        
        var songs: [Song] = []
        for doc in querySnapshot.documents {
            let song = try doc.data(as: Song.self)
            songs.append(song)
        }
        return songs
    }
}
