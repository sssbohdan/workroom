//
//  ThrottleTests.swift
//  DataStructuresTests
//
//  Created by Bohdan Savych on 17/04/2024.
//

import Foundation
import XCTest
@testable import DataStructures

final class ThrottleTests: XCTestCase {
    func test() {
        var counter = 0
        let exp = self.expectation(description: "Throttled function was invoked")
        let function = {
            counter += 1
            
        }
        let throttledFunction = throttle(
            function,
            timeInterval: .seconds(1)
        )

        throttledFunction()
        throttledFunction()
        throttledFunction()
        throttledFunction()
        XCTAssertEqual(counter, 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(counter, 1)
            exp.fulfill()
        }

        self.waitForExpectations(timeout: 1.1)
    }
}
