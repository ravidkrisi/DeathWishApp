//
//  Photo.swift
//  DeathWish
//
//  Created by Ravid Krisi on 23/12/2024.
//

import Foundation
import SwiftUI

struct Photo: Identifiable, Codable {
    var id = UUID().uuidString
    let caption: String
    let image: Data?
    var imagePath: String?
    
    init(caption: String, image: Data? = nil, imagePath: String? = nil) {
        self.caption = caption
        self.image = image
        self.imagePath = imagePath
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case caption
        case image
        case imagePath = "image_path"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.caption = try container.decode(String.self, forKey: .caption)
        self.image = try container.decodeIfPresent(Data.self, forKey: .image)
        self.imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.caption, forKey: .caption)
        try container.encodeIfPresent(self.image, forKey: .image)
        try container.encodeIfPresent(self.imagePath, forKey: .image)
    }
    
    static let example = Photo(caption: "example", image: Data(), imagePath: "users/3Wln2oZYcDZUpQkZDL7NRZnxZMk1/photos/426EE80D-03BF-4C86-AB6F-2A9365045858.jpeg")
}
