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
}
