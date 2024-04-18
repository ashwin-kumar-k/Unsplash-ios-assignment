//
//  Response.swift
//  Unsplash-Assignment
//
//  Created by Ashwin Kumar on 16/04/24.
//

import Foundation

// Struct representing a result from the Unsplash API
struct Result: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString // Unique identifier for the result
    let urls: URLs // URLs associated with the result
}

// Struct representing URLs associated with a result
struct URLs: Codable, Hashable {
    let thumb: String // URL for the thumbnail image
}
