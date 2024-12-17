//
//  Song.swift
//  DeathWish
//
//  Created by Ravid Krisi on 17/12/2024.
//

import Foundation

struct Song: Codable, Identifiable {
    let id: String
    let title: String
    let artist: String
    let album: String
}
