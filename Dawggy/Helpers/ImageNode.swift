//
//  ImageNode.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import Foundation
import UIKit.UIImage

protocol Node {
    associatedtype Value
    var key: String { get set }
    var value: Value { get set }
    var previous: Self? { get set }
    var next: Self? { get set }
}

final class ImageNode: Node {
    var key: String
    var value: UIImage
    var previous: ImageNode?
    var next: ImageNode?

    init(key: String, image: UIImage) {
        self.key = key
        self.value = image
    }
}
