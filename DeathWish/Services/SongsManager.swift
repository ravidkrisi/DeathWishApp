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
}
