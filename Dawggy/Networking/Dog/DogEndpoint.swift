//
//  DogEndpoint.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import Foundation

enum DogEndpoint: Endpoint {
    case random

    var baseURL: URL {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/") else { fatalError("URL is incorrect") }
        return url
    }

    var path: String {
        switch self {
        case .random:
            return "random"
        }
    }

    var headers: [String : String]? {
        return nil
    }

    var method: HTTPRequestMethod {
        switch self {
        case .random:
            return .get
        }
    }

    var body: Data? {
        return nil
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }
}
