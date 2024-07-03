//
//  ListTest.swift
//  DataStructuresTests
//
//  Created by Bohdan Savych on 03/07/2024.
//

import Foundation
import XCTest
@testable import DataStructures

final class ListTests: XCTestCase {
    func testAppend() {
        var list = List(element: 10)
        list.append(1)
        list.append(2)
        list.append(3)
        XCTAssertEqual(list.head.element, 10)
        XCTAssertEqual(list.head.next?.element, 1)
        XCTAssertEqual(list.head.next?.next?.element, 2)
        XCTAssertEqual(list.head.next?.next?.next?.element, 3)
    }

    func testHasCycles() {
        let list = List(element: "1")
        list.head.next = .init(element: "2")
        list.head.next?.next = .init(element: "3")
        list.head.next?.next?.next = list.head
        XCTAssertTrue(list.hasCycles())
        list.head.next?.next?.next = .init(element: "4")
        list.head.next?.next?.next?.next = list.head
        XCTAssertTrue(list.hasCycles())
        list.head.next?.next?.next?.next = nil
        XCTAssertFalse(list.hasCycles())

    }
}
