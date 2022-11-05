//
//  ReactiveTests.swift
//  AlgorithmsTests
//
//  Created by Bohdan Savych on 04/11/2022.
//

import XCTest

@testable import ReactivePattern

final class ReactiveTests: XCTestCase {
    func testCreateSequenceSubsribe() {
        let sequence = SimpleObservable<Int> { producer in
            producer(.next(1))
            producer(.next(2))
            producer(.next(3))
        }

        var value = 1
        sequence.observe { event in
            XCTAssertEqual(event, Event.next(value))
            value += 1
        }
    }
}
