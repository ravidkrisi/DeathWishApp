//
//  Storage.swift
//  DeathWish
//
//  Created by Ravid Krisi on 23/12/2024.
//

import Foundation
import FirebaseStorage

extension Storage {
    var usersRef: StorageReference {
        Storage.storage().reference().child("users")
    }
    
    func downloadFile(filePath: String) async throws -> Data? {
        let noteRef = Storage.storage().reference(withPath: filePath)
        
        return try await withCheckedThrowingContinuation { continuation in
            noteRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                    continuation.resume(throwing: error)
                } else if let data = data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}
