//
//  List.swift
//  DataStructures
//
//  Created by Bohdan Savych on 02/07/2024.
//

import Foundation

struct List<Element> {
    final class Node {
        var element: Element
        var next: Node?

        init(element: Element) {
            self.element = element
        }
    }

    let head: Node

    init(head: Node) {
        self.head = head
    }

    init(element: Element) {
        self.init(head: .init(element: element))
    }

    mutating func append(_ node: Node) {
        var lastNode = head
        while let last = lastNode.next {
            lastNode = last
        }

        lastNode.next = node

    }

    mutating func append(_ element: Element) {
        self.append(.init(element: element))
    }

    func hasCycles() -> Bool {
        var slow = head
        var fast = head.next


        while fast != nil {
            slow = slow.next!
            fast = fast?.next?.next

            if fast === slow {
                return true
            }
        }

        return false
    }
}
