//
//  Observable.swift
//  Algorithms
//
//  Created by Bohdan Savych on 04/11/2022.
//

import Foundation

protocol ObservableProtocol {
    associatedtype Value
    func observe(with onEvent: @escaping (Event<Value>) -> Void) -> Disposable
}

final class Observable<T>: ObservableProtocol {
    private let producer: (@escaping (Event<T>) -> Void) -> Disposable

    init(producer: @escaping (@escaping (Event<T>) -> Void) -> Disposable) {
        self.producer = producer
    }

    func observe(with onEvent: @escaping (Event<T>) -> Void) -> Disposable {
        self.producer(onEvent)
    }
}
