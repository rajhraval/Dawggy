//
//  LRUCacher.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import Foundation
import UIKit.UIImage

protocol LRUCache {
    associatedtype NodeType: Node
    var capacity: Int { get set }
    var nodes: [String: NodeType] { get set }
    var head: NodeType? { get set }
    var tail: NodeType? { get set }

    
    func set(_ value: NodeType.Value, for key: String)
    func get(for key: String) -> NodeType.Value?
    func getAll() -> [NodeType.Value]
    func removeAll() -> Bool
}

final class ImageLRUCache: LRUCache {
    
    var capacity: Int
    var nodes: [String : ImageNode] = [:]
    var head: ImageNode? = nil
    var tail: ImageNode? = nil

    private var diskManager: ImageDiskManager!

    init(capacity: Int = 2) {
        self.capacity = capacity
        self.diskManager = ImageDiskManager(capacity: capacity)
    }

    func set(_ value: UIImage, for key: String) {
        let newNode = ImageNode(key: key, image: value)
        if let node = nodes[key] {
            node.value = value
            moveToHead(node)
        } else {
            nodes[key] = newNode
            addNode(newNode)
            if nodes.count <= capacity {
                if let tailNode = tail {
                    removeNode(tailNode)
                    nodes.removeValue(forKey: tailNode.key)
                }
            }
        }
    }

    func get(for key: String) -> UIImage? {
        if let node = nodes[key] {
            moveToHead(node)
            return node.value
        } else {
            return diskManager.loadFromDisk(for: key)
        }
    }


    func getAll() -> [UIImage] {
        let images = diskManager.loadAllFromDisk()
        return images
    }

    func removeAll() -> Bool {
        clearCache()
        return diskManager.removeAll()
    }

    private func addNode(_ node: ImageNode) {
        diskManager.saveToDisk(value: node.value, for: node.key)
        node.next = head
        node.previous = nil
        head?.previous = node
        head = node
        if tail == nil {
            tail = head
        }
    }

    private func removeNode(_ node: ImageNode) {
        let prev = node.previous
        let next = node.next

        if node === head {
            head = next
        }
        if node === tail {
            tail = prev
        }

        prev?.next = next
        next?.previous = prev
    }

    private func moveToHead(_ node: ImageNode) {
        if node === head { return }
        removeNode(node)
        addNode(node)
    }

    private func clearCache() {
        nodes.removeAll()
        head = nil
        tail = nil
    }

}
