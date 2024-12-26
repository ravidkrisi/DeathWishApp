//
//  Firestore.swift
//  DeathWish
//
//  Created by Ravid Krisi on 25/12/2024.
//

import Foundation
import FirebaseFirestore

extension Firestore {
    
    func getCollectionDocs<T: Codable>(collectionRef: CollectionReference) async throws -> [T] {
        let snapshot = try await collectionRef.getDocuments()
        
        var array: [T] = []
        for doc in snapshot.documents {
            let item = try doc.data(as: T.self)
            array.append(item)
        }
        
        return array
    }
    
    func listenToCollection<T: Codable>(userId: String, collectionRef: CollectionReference, onUpdate: @escaping ([T]) -> Void) -> ListenerRegistration {
        return collectionRef.addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error listening to songs: \(error)")
                    return
                }
                
                let songs = snapshot?.documents.compactMap { document in
                    try? document.data(as: T.self)
                } ?? []
                
                DispatchQueue.main.async {
                    onUpdate(songs)
                }
            }
    }
}
