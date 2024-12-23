//
//  FavoriteSongsView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 19/12/2024.
//

import SwiftUI

struct FavoriteSongsView: View {
    
    @Binding var currUser: DBUser?
    
    @State var songs: [Song] = []
    
    var body: some View {
        songsList
        .navigationTitle("Favorite Songs")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("Add") {
                    SongFormView(currUser: $currUser)
                }
            }
        }
        .onAppear {
            Task {
                guard let currUser else { return }
                self.songs = try await SongsManager.shared.getUsersFavoriteSongs(userId: currUser.id)
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteSongsView(currUser: .constant(DBUser.example))
    }
}

extension FavoriteSongsView {
    var songsList: some View {
        List {
            ForEach(songs) { song in
                HStack {
                    VStack(alignment: .leading) {
                        Text(song.title)
                        Text(song.artist)
                    }
                }
            }
        }
    }
}
