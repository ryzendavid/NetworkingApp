//
//  NetworkingModel.swift
//  NetworkingApp
//
//  Created by David Adekunle on 02/03/2025.
//

import Foundation

struct GHUser: Codable {
    let login : String
    let avatarUrl : String
    let bio: String
    let twitterUsername : String
}

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case inavalidData
    case decodingFailed
}
