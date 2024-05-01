//
//  Observable.swift
//  Algorithms
//
//  Created by Bohdan Savych on 04/11/2022.
//

import Foundation

protocol Observable {
    associatedtype Value
    func observe(with onEvent: @escaping (Event<Value>) -> Void) -> Disposable
}

extension Observable {
    func toObservable() -> ObservableSequence<Value> {
        ObservableSequence(producer: self.observe(with:))
    }
}

final class ObservableSequence<T>: Observable {
    private let producer: (@escaping (Event<T>) -> Void) -> Disposable

    init(producer: @escaping (@escaping (Event<T>) -> Void) -> Disposable) {
        self.producer = producer
    }

    func observe(with onEvent: @escaping (Event<T>) -> Void) -> Disposable {
        self.producer(onEvent)
    }

    func observeNext(with onNext: @escaping (T) -> Void) -> Disposable {
        let closure: (Event<T>) -> Void = {
            $0.map {
                onNext($0)
            }
        }

        return self.observe(with: closure)
    }
}

// MARK: - Factory
extension ObservableSequence {
    static func failure(_ error: NSError) -> ObservableSequence<Value> {
        .init {
            $0(.failure(error))
            return EmptyDisposable()
        }
    }

    static var completed: ObservableSequence<Value> {
        .init {
            $0(.completed)
            return EmptyDisposable()
        }
    }
}
