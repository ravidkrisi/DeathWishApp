//
//  NotesView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 21/12/2024.
//

import SwiftUI

@MainActor
final class NotesViewModel: ObservableObject {
    
    @Published var notes: [Note] = []
    
    func getNotes(userId: String) {
        Task {
            self.notes = try await NotesManager.shared.getNotes(userId: userId)
        }
    }
}

struct NotesView: View {
    
    @Binding var currUser: DBUser?
    
    @StateObject var vm = NotesViewModel()
    
    var body: some View {
        List {
            ForEach(vm.notes) { note in
                NavigationLink {
                    NoteView(note: note)
                } label: {
                    VStack {
                        Text(note.title)
                            .font(.headline)
                    }
                }

            }
        }
        .navigationTitle("Notes")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddNoteView(currUser: $currUser)
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .onAppear {
            guard let currUser else { return }
            vm.getNotes(userId: currUser.id)
        }
    }
}

#Preview {
    NavigationStack {
        NotesView(currUser: .constant(DBUser.example))
    }
}
