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
        let sequence = Observable<Int> { producer in
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
        let publishSubject = Publishable<Int>()
        let value = 10
        let disposable = publishSubject.observe { event in
            XCTAssertEqual(event, Event.next(value))
        }
        publishSubject.send(event: .next(value))
        disposable.dispose()
    }

    func testMapFilter() {
        let publishSubject = Publishable<Int>()
        let disposable = publishSubject
            .filter { $0 > 10 }
            .map { "\($0)"}
            .observe { event in
                XCTAssertEqual(event, Event.next("11"))
        }

        for i in 0...11 {
            publishSubject.sendNext(i)
        }
        disposable.dispose()
    }
}
