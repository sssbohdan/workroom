//
//  DebounceTests.swift
//  DataStructuresTests
//
//  Created by Bohdan Savych on 30/06/2024.
//

import Foundation
import XCTest
@testable import DataStructures

final class DebounceTests: XCTestCase {
    func testSecondsDebounce() {
        var counter = 0
        let exp = self.expectation(description: "Function was called")
        var f = {
            counter += 1
        }
        let debouncedFunction = debounce(timeInterval: .seconds(2), f)
        for _ in 0...10000 {
            debouncedFunction()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            debouncedFunction()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            debouncedFunction()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            debouncedFunction()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(counter, 1)
            exp.fulfill()
        }

        self.waitForExpectations(timeout: 2.1)
    }
}
