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
}
