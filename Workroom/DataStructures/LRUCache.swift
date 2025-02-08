//
//  LRUCache.swift
//  DataStructures
//
//  Created by Bohdan Savych on 02/02/2025.
//

import Foundation

public final class LRUCache<Object: Hashable> {
    private lazy var _cache = [String: Object]()
    private let limit: Int
    private lazy var lastUsedIndices = [String: Int]()

    init(limit: Int) {
        self.limit = limit
    }

    public func setObject(_ object: Object, for key: String) {
        if _cache.values.count > limit {
            let toRemove = lastUsedIndices.min {
                $0.value > $1.value
            }!.key
            _cache[toRemove] = nil
            lastUsedIndices[toRemove] = nil
        }

        _cache[key] = object
        lastUsedIndices[key] = lastUsedIndices.max {
            $0.value > $1.value
        }?.value
    }

    public func object(for key: String) -> Object? {
        lastUsedIndices.keys.forEach {
            lastUsedIndices[$0, default: 0] -= 1
        }
        lastUsedIndices[key,default: 0] += 1

        return _cache[key]
    }
}



//final class LRUCache<Key: Hashable, Value> {
//    private class Node {
//        let key: Key
//        var value: Value
//        var prev: Node?
//        var next: Node?
//
//        init(key: Key, value: Value) {
//            self.key = key
//            self.value = value
//        }
//    }
//
//    private let capacity: Int
//    private var dict = [Key: Node]()
//    private var head: Node?  // Most recently used
//    private var tail: Node?  // Least recently used
//
//    init(capacity: Int) {
//        self.capacity = capacity
//    }
//
//    func get(_ key: Key) -> Value? {
//        guard let node = dict[key] else { return nil }
//        moveToHead(node)
//        return node.value
//    }
//
//    func set(_ key: Key, value: Value) {
//        if let node = dict[key] {
//            node.value = value
//            moveToHead(node)
//        } else {
//            let newNode = Node(key: key, value: value)
//            if dict.count == capacity, let tail = tail {
//                // Evict the least recently used
//                dict[tail.key] = nil
//                remove(tail)
//            }
//            dict[key] = newNode
//            addToHead(newNode)
//        }
//    }
//
//    // Helper methods to manage the linked list:
//
//    private func addToHead(_ node: Node) {
//        node.next = head
//        node.prev = nil
//        head?.prev = node
//        head = node
//        if tail == nil {
//            tail = node
//        }
//    }
//
//    private func remove(_ node: Node) {
//        if let prev = node.prev {
//            prev.next = node.next
//        } else {
//            head = node.next
//        }
//        if let next = node.next {
//            next.prev = node.prev
//        } else {
//            tail = node.prev
//        }
//    }
//
//    private func moveToHead(_ node: Node) {
//        remove(node)
//        addToHead(node)
//    }
//}
