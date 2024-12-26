//
//  FavoriteSongsView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 19/12/2024.
//

import SwiftUI
final class FavoriteSongsViewModel: ObservableObject {
    @Published var songs: [Song] = []
    
    func startListen(userId: String) {
        SongsManager.shared.listenToUsersFavoriteSongs(userId: userId) { [weak self] UpdatedSongs in
            self?.songs = UpdatedSongs
        }
    }
}

struct FavoriteSongsView: View {
    
    @Binding var currUser: DBUser?
    
    @StateObject var vm = FavoriteSongsViewModel()
    
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
            guard let userId = currUser?.id else { return }
            vm.startListen(userId: userId)
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
            ForEach(vm.songs) { song in
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
