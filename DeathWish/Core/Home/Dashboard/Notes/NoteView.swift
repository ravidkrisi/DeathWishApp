//
//  NoteView.swift
//  DeathWish
//
//  Created by Ravid Krisi on 21/12/2024.
//

import SwiftUI

struct NoteView: View {
    
    let note: Note
    
    var body: some View {
        VStack {
            Text(note.title)
                .font(.title)
            
            Text(note.body ?? "")
                .font(.caption)
        }
    }
}

#Preview {
    NoteView(note: Note.example)
}
