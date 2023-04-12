//
//  Queue.swift
//  DataStructures
//
//  Created by Bohdan Savych on 12/12/2022.
//

import Foundation

struct Queue<Element>  {
    private var left: [Element] = []
    private var right: [Element] = []
    /// Add an element to the back of the queue.
    /// - Complexity: O(1).
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    /// Removes front of the queue.
    /// Returns `nil` in case of an empty queue.
    /// - Complexity: Amortized O(1).
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}
