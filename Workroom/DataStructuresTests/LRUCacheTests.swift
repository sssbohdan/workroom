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
        let cache = LRUCache<String>(limit: 2)
        cache.setObject("1", for: "key1")
        XCTAssertEqual(cache.object(for: "key1"), "1")
    }
}
