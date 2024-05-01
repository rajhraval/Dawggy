//
//  APIError.swift
//  Dawggy
//
//  Created by Raj Raval on 28/01/24.
//

import Foundation

enum APIError: Error {
    case invalidURLError
    case networkingError(error: Error)
    case decodingError(error: Error)
    case internetError
    case unknownError(error: Error)

    var title: String {
        switch self {
        case .internetError:
            return "Connection Failed"
        default:
            return "Something's Wrong"
        }
    }

    var description: String {
        switch self {
        case .internetError:
            return "Check your connection."
        default:
            return "Try again later."
        }
    }

    var image: String {
        switch self {
        case .internetError:
            return "wifi.slash"
        default:
            return "pc"
        }
    }
}

