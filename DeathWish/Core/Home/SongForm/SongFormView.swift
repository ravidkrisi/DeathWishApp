//
//  SongFormView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 17/12/2024.
//

import SwiftUI

@MainActor
final class SongFormViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var artist: String = ""
    @Published var album: String = ""
    
    func addSongToFavorites(userId: String) {
        Task {
            let song = Song(title: title, artist: artist, album: album)
            
            try await SongsManager.shared.addSongToDB(song: song, userId: userId)
            print("song added successfully")
        }
    }
}

struct SongFormView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm = SongFormViewModel()
    
    @Binding var currUser: DBUser?
    
    var body: some View {
        List {
            TextField("Title", text: $vm.title)
            TextField("Artist", text: $vm.artist)
            TextField("Album", text: $vm.album)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add") {
                    if let currUser {
                        vm.addSongToFavorites(userId: currUser.id)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SongFormView(currUser: .constant(DBUser.example))
    }
}
