//
//  UIImage+.swift
//  Dawggy
//
//  Created by Raj Raval on 25/04/24.
//

import UIKit.UIImage

extension [UIImage] {

    func toJPEGData(compressionQuality: CGFloat = 0.75) -> [Data] {
        return self.compactMap { $0.jpegData(compressionQuality: compressionQuality) }
    }

    var toPNGData: [Data] {
        return self.compactMap { $0.pngData() }
    }

}

extension UIImage {
    var toPNGData: Data {
        guard let data = self.pngData() else {
            return Data()
        }
        return data
    }
}

