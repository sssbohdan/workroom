//
//  FlatMapLatestTests.swift
//  ReactivePatternTests
//
//  Created by Bohdan Savych on 30/04/2024.
//

import XCTest
@testable import ReactivePattern

final class FlatMapLatestTests: XCTestCase {
    let bag = DisposeBag()
    func testFlatMap() {
        let publisher1 = Publisher<Int>()
        let publisher2 = Publisher<String>()
        let seq = publisher1.flatMap { v in
            publisher2.toObservable().map { "\(v)\($0)" }
        }

        var acc = [String]()
        seq.observeNext { elem in
            acc.append(elem)
        }
        .dispose(in: bag)

        publisher1.sendNext(1)
        publisher2.sendNext("a")
        publisher1.sendNext(2)
        publisher2.sendNext("b")
        publisher2.sendNext("c")

        XCTAssertEqual(acc, ["1a", "1b", "2b", "1c", "2c"])
    }

    func testFlatMapLatest() {
        let publisher1 = Publisher<Int>()
        let publisher2 = Publisher<String>()
        let seq = publisher1.flatMapLatest { v in
            publisher2.toObservable().map { "\(v)\($0)" }
        }

        var acc = [String]()
        seq.observeNext { elem in
            acc.append(elem)
        }
        .dispose(in: bag)

        publisher1.sendNext(1)
        publisher2.sendNext("a")
        publisher1.sendNext(2)
        publisher2.sendNext("b")
        publisher2.sendNext("c")

        XCTAssertEqual(acc, ["1a", "2b", "2c"])
    }

}
