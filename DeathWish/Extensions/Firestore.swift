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
    
    func getCollectionDocsRealtime<T: Codable>(
        collectionRef: CollectionReference,
        completion: @escaping (Result<[T], Error>) -> Void
    ) -> ListenerRegistration {
        let listener = collectionRef.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                completion(.failure(NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "No snapshot found."])))
                return
            }
            
            do {
                let array = try snapshot.documents.map { try $0.data(as: T.self) }
                completion(.success(array))
            } catch {
                completion(.failure(error))
            }
        }
        
        return listener
    }

}
