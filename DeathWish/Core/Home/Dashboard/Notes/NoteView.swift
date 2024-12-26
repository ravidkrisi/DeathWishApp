//
//  NoteView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 21/12/2024.
//

import SwiftUI

@MainActor
final class NoteViewModel: ObservableObject {
    @Published var noteBody: String = ""
    
    func getNoteBody(bodyPath: String) {
        Task {
            guard let body = try await NotesManager.shared.downloadBodyNote(bodyPath: bodyPath) else { return }
            self.noteBody = body
        }
    }
}

struct NoteView: View {
    
    let note: Note
    
    @StateObject var vm = NoteViewModel()
    
    var body: some View {
        VStack {
            Text(note.title)
                .font(.title)
            
            Text(vm.noteBody)
                .font(.caption)
        }
        .onAppear {
            guard let bodyPath = note.bodyPath else { return }
            vm.getNoteBody(bodyPath: bodyPath)
        }
    }
}

#Preview {
    NoteView(note: Note.example)
}
