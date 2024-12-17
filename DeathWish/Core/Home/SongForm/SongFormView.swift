//
//  SongFormView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 17/12/2024.
//

import SwiftUI

final class SongFormViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var artist: String = ""
    @Published var album: String = ""
}

struct SongFormView: View {
    
    @StateObject var vm = SongFormViewModel()
    
    var body: some View {
        List {
            TextField("Title", text: $vm.title)
            TextField("Artist", text: $vm.artist)
            TextField("Album", text: $vm.album)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add") {
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SongFormView()
    }
}
