//
//  TopologicalSortTests.swift
//  AlgorithmsTests
//
//  Created by Bohdan Savych on 10/02/2025.
//

import XCTest
@testable import Algorithms

final class TopologicalSortTests: XCTestCase {
    func test1() {
        let graph: [Int: [Int]] = [
            0: [1, 2],
            1: [3],
            2: [3],
            3: []
        ]
        let sorted = topologicalSortBFS(graph)
        XCTAssertEqual(sorted, [0, 1, 2, 3])
    }

    func test2() {
        let graph: [Int: [Int]] = [
            0: [1, 2, 3],
            1: [3],
            2: [3, 4],
            3: [4],
            4: []
        ]
        let sorted = topologicalSortBFS(graph)
        XCTAssertEqual(sorted, [0, 1, 2, 3, 4])

    }
}
