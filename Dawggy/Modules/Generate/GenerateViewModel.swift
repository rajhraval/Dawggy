//
//  GenerateViewModel.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import UIKit.UIImage

final class GenerateViewModel: ObservableObject {
    
    @Published var dogResponse: DogResponse?

    private var dogService: DogService!
    private var imageCacher: ImageLRUCache!

    init(dogService: DogService = DogService(), imageCacher: ImageLRUCache = ImageLRUCache()) {
        self.dogService = dogService
        self.imageCacher = imageCacher
    }

    func getRandomDog() {
        Task {
            do {
                dogResponse = try await dogService.getRandomDog()
                await saveImageToCache(from: dogResponse)
            } catch let error {
                Log.error(error)
            }
        }
    }

    private func saveImageToCache(from response: DogResponse?) async {
        guard let response = response else { return }
        Task(priority: .background) {
            do {
                let data = try await dogService.getDogImageData(from: response.imageURL)
                if let image = UIImage(data: data) {
                    imageCacher.set(image, for: response.imageName)
                }
            } catch let error {
                Log.error(error)
            }
        }
    }


}
