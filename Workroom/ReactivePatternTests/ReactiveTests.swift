//
//  ReactiveTests.swift
//  AlgorithmsTests
//
//  Created by Bohdan Savych on 04/11/2022.
//

import XCTest

@testable import ReactivePattern

final class ReactiveTests: XCTestCase {
    func testCreateSequenceSubscribe() {
        let sequence = ObservableSequence<Int> { producer in
            producer(.next(1))
            producer(.next(2))
            producer(.next(3))

            return EmptyDisposable()
        }

        var value = 1
        let disposable = sequence.observe { event in
            XCTAssertEqual(event, Event.next(value))
            value += 1
        }
        disposable.dispose()
    }

    func testPublishable() {
        let publisher = Publisher<Int>()
        let value = 10
        let disposable = publisher.observe { event in
            XCTAssertEqual(event, Event.next(value))
        }
        publisher.send(event: .next(value))
        disposable.dispose()
    }

    func testMapFilter() {
        let publisher = Publisher<Int>()
        let disposable = publisher
            .filter { $0 > 10 }
            .map { "\($0)"}
            .observe { event in
                XCTAssertEqual(event, Event.next("11"))
        }

        for i in 0...11 {
            publisher.sendNext(i)
        }
        disposable.dispose()
    }
}
