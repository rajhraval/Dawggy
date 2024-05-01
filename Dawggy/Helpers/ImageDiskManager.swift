//
//  ImageDiskManager.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import UIKit.UIImage

final class ImageDiskManager: DiskManager {

    var capacity: Int

    init(capacity: Int) {
        self.capacity = capacity
    }

    func saveToDisk(value: UIImage, for key: String) {
        let url = getDocumentsDirectory().appendingPathComponent("\(key).png")
        do {
            try value.toPNGData.write(to: url)
            manageStorage()
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

    func manageStorage() {
        do {
            let directoryURL = getDocumentsDirectory()
            let fileURLs = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: [.creationDateKey], options: .skipsHiddenFiles)

            // Mapping files with their creation dates and sorting them
            let filesWithDates = try fileURLs.map { url -> (url: URL, creationDate: Date) in
                let resourceValues = try url.resourceValues(forKeys: [.creationDateKey])
                guard let creationDate = resourceValues.creationDate else {
                    throw NSError(domain: "ManageStorageError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Creation date not available for \(url.lastPathComponent)"])
                }
                return (url: url, creationDate: creationDate)
            }.sorted {
                $0.creationDate > $1.creationDate // Sort by date descending (newest first)
            }

            // Determine the files to remove if there are more than the capacity allows
            let filesToRemove = filesWithDates.dropFirst(capacity)

            // Remove files exceeding the capacity
            for file in filesToRemove {
                try fileManager.removeItem(at: file.url)
                print("Removed old file: \(file.url.lastPathComponent)")
            }
        } catch {
            print("Error managing storage: \(error)")
        }
    }

}

