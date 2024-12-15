//
//  BinaryTree.swift
//  DataStructures
//
//  Created by Bohdan Savych on 19/11/2024.
//

import Foundation

final class BinaryTree<T: Hashable> {

    private(set) var root: Node?

    init() {}

    init(array: [T]) {
        guard !array.isEmpty else { return }
        array.forEach(self.insert)
    }

    func insert(_ value: T) {
        guard let root else {
            root = .init(value: [value])
            return
        }

        var parent = root

        while true {
            if value.hashValue < parent.value[0].hashValue {
                if let left = parent.left {
                    parent = left
                } else {
                    parent.left = .init(value: [value])
                    break
                }
            } else if value.hashValue > parent.value[0].hashValue {
                if let right = parent.right {
                    parent = right
                } else {
                    parent.right = .init(value: [value])
                    break
                }
            } else {
                if !parent.value.contains(value) {
                    parent.value.append(value)
                }
                break // not storing duplicated values
            }
        }
    }

    func contains(_ value: T) -> Bool {
        var _parent = root

        while let parent = _parent {
            if value.hashValue < parent.value[0].hashValue {
                _parent = parent.left
            } else if value.hashValue > parent.value[0].hashValue {
                _parent = parent.right
            } else {
                return parent.value.contains(value)
            }
        }

        return false
    }
}


// MARK: - Node
extension BinaryTree {
    final class Node {
        fileprivate(set) var value: [T]
        var left: Node?
        var right: Node?

        init(value: [T], left: Node? = nil, right: Node? = nil) {
            self.value = value
            self.left = left
            self.right = right
        }
    }
}
