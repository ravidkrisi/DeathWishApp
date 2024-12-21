//
//  NotesManager.swift
//  DeathWish
//
//  Created by Ravid Krisi on 21/12/2024.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

final class NotesManager {
    
    static let shared = NotesManager()
    private init() { }
    
    private let usersRef = Storage.storage().reference().child("users")
    
    private func getNoteRef(userId: String, noteId: String) -> StorageReference {
        usersRef.child("\(userId)/notes/\(noteId)_body.txt")
    }
    
    
    private func saveBodyToStorage(userId: String, note: Note) async throws -> StorageMetadata? {
        guard let data = note.body.data(using: .utf8) else { return nil }
        
        let noteRef = getNoteRef(userId: userId, noteId: note.id)
        
        return try await noteRef.putDataAsync(data)
    }
    
    private func saveNoteToDB(userId: String, note: Note, bodyPath: String) async throws {
        let usersNotesCollection = UsersManager.shared.userDoc(userId: userId).collection("notes")
        
        let data: [String: Any] = [
            "id" : note.id,
            "title" : note.title,
            "body_path" : bodyPath
        ]
        try await usersNotesCollection.document("\(note.id)").setData(data)
    }
    
    func saveNote(userId: String, note: Note) async throws {
        guard let noteRef = try await saveBodyToStorage(userId: userId, note: note) else { return }
        try await saveNoteToDB(userId: userId, note: note, bodyPath: noteRef.path ?? "")
    }
    
}
