//
//  MD2Tests.swift
//  AlgorithmsTests
//
//  Created by Bohdan Savych on 20/12/2024.
//

import XCTest
@testable import Algorithms

final class MD2Tests: XCTestCase {
    func testAlgo() {
        XCTAssertEqual("9560212d847ba2054621b25d4e44d723", MD2.hash("Hello!"))
    }
}
