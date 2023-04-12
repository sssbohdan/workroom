//
//  Stack.swift
//  DataStructures
//
//  Created by Bohdan Savych on 12/12/2022.
//

import Foundation

struct Stack<Element> {
    private var array = [Element]()

    @discardableResult
    mutating  func pop() -> Element? {
        array.popLast()
    }

    mutating func push(_ element: Element) {
        array.append(element)
    }
}
