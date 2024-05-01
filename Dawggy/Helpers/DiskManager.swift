//
//  DiskManager.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import Foundation

protocol DiskManager {
    associatedtype Value
    var fileManager: FileManager { get }
    var capacity: Int { get set }

    func saveToDisk(value: Value, for key: String)
    func loadFromDisk(for key: String) -> Value?
    func loadAllFromDisk() -> [Value]
    func removeAll() -> Bool
    func getDocumentsDirectory() -> URL
}

extension DiskManager {
    var fileManager: FileManager {
        return .default
    }
    func getDocumentsDirectory() -> URL {
       let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
       return paths[0]
   }
}

