//
//  Emitable.swift
//  Algorithms
//
//  Created by Bohdan Savych on 04/11/2022.
//

import Foundation

protocol Publishable {
    associatedtype Value

    func send(event: Event<Value>)
}

final class Publisher<T>: Publishable, Observable {
    private lazy var subscribers = [EquatableEventClosure<T>]()

    func observe(with onEvent: @escaping (Event<T>) -> Void) -> Disposable {
        let equatableClosure = EquatableEventClosure(onEvent)
        self.subscribers.append(equatableClosure)
        let blockDisposable = BlockDisposable { [weak self] in
            self?.subscribers.removeAll(where: {
                $0 == equatableClosure
            })
        }

        return blockDisposable
    }

    func send(event: Event<T>) {
        self.subscribers.forEach { $0.closure(event) }
    }

    func sendNext(_ value: T) {
        self.subscribers.forEach { $0.closure(.next(value)) }
    }
}
