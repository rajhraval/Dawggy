//
//  URL+.swift
//  TriviaBuddy
//
//  Created by Raj Raval on 28/01/24.
//

import UIKit.UIImage

extension URL: API {
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Unable to create URL for \(appGroup)")
        }
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
