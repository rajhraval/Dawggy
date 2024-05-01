//
//  ImageDiskManager.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import UIKit.UIImage

final class ImageDiskManager: DiskManager {

    func saveToDisk(value: UIImage, for key: String) {
        let url = getDocumentsDirectory().appendingPathComponent("\(key).png")
        do {
            try value.toPNGData.write(to: url)
            Log.info("Saved Image to disk: \(url.path)")
        } catch let error {
            Log.error(error)
        }
    }

    func loadFromDisk(for key: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent("\(key).png")
        if let imageData = try? Data(contentsOf: url) {
            return UIImage(data: imageData)
        } else {
            Log.info("Failed to load image from: \(url.path)")
            return nil
        }
    }

    func loadAllFromDisk() -> [UIImage] {
        var images: [UIImage] = []
        do {
            let documentsDirectory = getDocumentsDirectory()
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs where fileURL.pathExtension == "png" {
                let key = fileURL.deletingPathExtension().lastPathComponent
                if let image = loadFromDisk(for: key) {
                    images.append(image)
                }
            }
            return images
        } catch let error {
            Log.error(error)
            return []
        }
    }

    func removeAll() -> Bool {
        do {
            let documentsDirectory = getDocumentsDirectory()
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs where fileURL.pathExtension == "png" {
                let key = fileURL.deletingPathExtension().lastPathComponent
                if let _ = loadFromDisk(for: key) {
                    try fileManager.removeItem(at: fileURL)
                }
            }
            return true
        } catch let error {
            Log.error(error)
            return false
        }
    }

}

