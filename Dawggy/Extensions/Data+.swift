//
//  Data+.swift
//  Dawggy
//
//  Created by Raj Raval on 25/04/24.
//

import Foundation

extension Data {
    var prettyPrintToJSON: NSString {
        /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else {
            return (String(data: self, encoding: .utf8) ?? "Cannot render string in .UTF8 format") as NSString
        }

        return prettyPrintedString
    }
}
