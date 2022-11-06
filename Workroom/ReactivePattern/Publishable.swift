//
//  Emitable.swift
//  Algorithms
//
//  Created by Bohdan Savych on 04/11/2022.
//

import Foundation

protocol PublishableProtocol {
    associatedtype Value

    func send(event: Event<Value>)
}

final class Publishable<T>: PublishableProtocol, ObservableProtocol {
    private lazy var subsribers = [EquatableEventClosure<T>]()

    func observe(with onEvent: @escaping (Event<T>) -> Void) -> Disposable {
        let equatableClosure = EquatableEventClosure(onEvent)
        self.subsribers.append(equatableClosure)
        let blockDisposable = BlockDisposable { [weak self] in
            self?.subsribers.removeAll(where: {
                $0 == equatableClosure
            })
        }

        return blockDisposable
    }

    func send(event: Event<T>) {
        self.subsribers.forEach { $0.closure(event) }
    }

    func sendNext(_ value: T) {
        self.subsribers.forEach { $0.closure(.next(value)) }
    }
}
