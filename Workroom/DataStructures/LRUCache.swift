//
//  LRUCache.swift
//  DataStructures
//
//  Created by Bohdan Savych on 02/02/2025.
//

import Foundation

final class LRUCache<Key: Hashable, Value> {
    private class Node {
        let key: Key
        var value: Value
        weak var prev: Node?
        var next: Node?

        init(key: Key, value: Value) {
            self.key = key
            self.value = value
        }
    }

    private let capacity: Int
    private var dict = [Key: Node]()
    private var head: Node?
    private var tail: Node?

    init(capacity: Int) {
        self.capacity = capacity
    }

    func object(for key: Key) -> Value? {
        guard let node = dict[key] else { return nil }
        moveToHead(node)
        return node.value
    }

    func setObject(_ object: Value, for key: Key) {
        if let node = dict[key] {
            node.value = object
            moveToHead(node)
        } else {
            let newNode = Node(key: key, value: object)
            if dict.count == capacity, let tail = tail {
                // Evict the least recently used
                dict[tail.key] = nil
                remove(tail)
            }
            dict[key] = newNode
            addToHead(newNode)
        }
    }

    private func addToHead(_ node: Node) {
        node.next = head
        node.prev = nil
        head?.prev = node
        head = node
        if tail == nil {
            tail = node
        }
    }

    private func remove(_ node: Node) {
        if let prev = node.prev {
            prev.next = node.next
        } else {
            head = node.next
        }
        if let next = node.next {
            next.prev = node.prev
        } else {
            tail = node.prev
        }
    }

    private func moveToHead(_ node: Node) {
        remove(node)
        addToHead(node)
    }
}
