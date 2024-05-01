import XCTest
@testable import ReactivePattern

final class CombineLatestTests: XCTestCase {
    let bag = DisposeBag()
    func testCombineLatest() {
        let publisher1 = Publisher<String>()
        let publisher2 = Publisher<String>()
        let publisher3 = Publisher<String>()

        var acc = ""
        combineLatest(publisher1.toObservable(), obs2: publisher2.toObservable(), obs3: publisher3.toObservable())
            .observeNext { tuple in
                acc = tuple.0 + tuple.1 + tuple.2
            }
            .dispose(in: self.bag)


        publisher1.sendNext("a")
        XCTAssertTrue(acc.isEmpty)
        publisher2.sendNext("b")
        XCTAssertTrue(acc.isEmpty)
        publisher3.sendNext("c")
        XCTAssertEqual(acc, "abc")

    }
}
