//
//  AddNoteView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 22/12/2024.
//

import SwiftUI

@MainActor
final class AddNoteViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var body: String = ""
    
    func addNote(userId: String) {
        Task {
            let note = Note(title: title, body: body)
            try await NotesManager.shared.saveNote(userId: userId, note: note)
        }
    }
}
struct AddNoteView: View {
    
    @StateObject var vm = AddNoteViewModel()
    @Binding var currUser: DBUser?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Title", text: $vm.title)
                .font(.headline)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            TextEditor(text: $vm.body)
                .font(.headline)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray.opacity(0.2), lineWidth: 5)
                }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add") {
                    guard let currUser else { return }
                    vm.addNote(userId: currUser.id)
                    dismiss()
                }
            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        AddNoteView(currUser: .constant(DBUser.example))
    }
}
