//
//  UIImageView+.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import UIKit.UIImageView

extension UIImageView: API {

    func setImage(_ url: URL) {
        Task { @MainActor in
            do {
                self.image = try await requestImage(from: url)
            } catch let error {
                self.image = nil
                Log.error(error)
            }
        }
    }

}
