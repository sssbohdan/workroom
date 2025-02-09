//
//  LRUCacheTests.swift
//  DataStructuresTests
//
//  Created by Bohdan Savych on 02/02/2025.
//

import Foundation
import XCTest
@testable import DataStructures

final class LRUCacheTests: XCTestCase {
    func testSetGet() {
        let cache = LRUCache<String, String>(capacity: 2)
        cache.setObject("1", for: "key1")
        XCTAssertEqual(cache.object(for: "key1"), "1")
    }

    func testCapacity() {
        let cache = LRUCache<String, String>(capacity: 2)
        cache.setObject("1", for: "key1")
        cache.setObject("2", for: "key2")
        cache.setObject("3", for: "key3")

        XCTAssertNil(cache.object(for: "key1"))
    }

    func testNonRecentElementRemoved() {
        let cache = LRUCache<String, String>(capacity: 2)
        cache.setObject("1", for: "key1")
        cache.setObject("2", for: "key2")
        _ = cache.object(for: "key1")
        cache.setObject("3", for: "key3")
        XCTAssertNil(cache.object(for: "key2"))
        XCTAssertNotNil(cache.object(for: "key1"))
    }
}
