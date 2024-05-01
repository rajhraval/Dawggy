//
//  RecentViewModel.swift
//  Dawggy
//
//  Created by Raj Raval on 28/04/24.
//

import UIKit.UIImage

final class RecentViewModel: ObservableObject {

    @Published var images: [UIImage] = []

    private var imageLRUCacher: ImageLRUCache!

    init(imageLRUCacher: ImageLRUCache = ImageLRUCache()) {
        self.imageLRUCacher = imageLRUCacher
    }

    func getAllImages() {
        images = imageLRUCacher.getAll()
        Log.info("Images: \(images.count)")
    }

    func removeAllImages() {
        if imageLRUCacher.removeAll() {
            images.removeAll()
        }
    }

}
