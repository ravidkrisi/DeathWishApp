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
    
    // SAVE NOTES
    private func saveBodyToStorage(userId: String, note: Note) async throws -> StorageMetadata? {
        guard let data = note.body?.data(using: .utf8) else { return nil }
        
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
    
    // GET NOTES
    private func downloadBodyNote(bodyPath: String) async throws -> String? {
        let noteRef = Storage.storage().reference(withPath: bodyPath)
        
        return try await withCheckedThrowingContinuation { continuation in
            noteRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    let bodyNote = String(data: data, encoding: .utf8)
                    continuation.resume(returning: bodyNote)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    
    func getNotes(userId: String) async throws -> [Note] {
        let usersNotesCollection = UsersManager.shared.userDoc(userId: userId).collection("notes")
        let snapshot = try await usersNotesCollection.getDocuments()
        
        var notes: [Note] = []
        for doc in snapshot.documents {
            var note = try doc.data(as: Note.self)
            
            if let bodyPath = note.bodyPath {
                note.body = try await downloadBodyNote(bodyPath: bodyPath)
            }
            notes.append(note)
        }
        
        return notes
    }
}
