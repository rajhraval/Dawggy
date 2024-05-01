//
//  DogResponse.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import Foundation

struct DogResponse: Codable {
    let url: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case url = "message"
        case status
    }

    var imageName: String {
        return "Dawggy-Dog-\(UUID().uuidString)"
    }

    var imageURL: URL {
        guard let url = URL(string: url) else { fatalError("URL is not correct") }
        return url
    }
}
