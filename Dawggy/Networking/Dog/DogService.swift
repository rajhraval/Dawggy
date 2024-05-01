//
//  DogService.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import UIKit.UIImage

final class DogService: API {

    func getRandomDog() async throws -> DogResponse {
        try await request(DogEndpoint.random) as DogResponse
    }

    func getDogImageData(from url: URL) async throws -> Data {
        try await requestImageData(from: url)
    }

}
