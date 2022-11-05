//
//  Observable.swift
//  Algorithms
//
//  Created by Bohdan Savych on 04/11/2022.
//

import Foundation

protocol Observable {
    func observe<T>(with onEvent: (Event<T>) -> Void) -> Disposable
}

final class SimpleObservable<T> {
    private let producer: ((Event<T>) -> Void) -> Void

    init(producer: @escaping ((Event<T>) -> Void) -> Void) {
        self.producer = producer
    }

    func observe(with onEvent: (Event<T>) -> Void) -> Disposable {
        self.producer(onEvent)

        return EmptyDisposable()
    }
}
