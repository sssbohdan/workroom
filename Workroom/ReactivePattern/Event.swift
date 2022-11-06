//
//  Event.swift
//  Algorithms
//
//  Created by Bohdan Savych on 04/11/2022.
//

import Foundation

enum Event<T> {
    case next(T)
    case failure(NSError)
    case completed

    func map<K>(_ f: (T) -> K) -> Event<K> {
        switch self {
        case .next(let value):
            return .next(f(value))
        case .failure(let error):
            return .failure(error)
        case .completed:
            return .completed
        }
    }
}

extension Event: Equatable where T: Equatable {}

final class EquatableEventClosure<T>: Equatable {
    let id: UUID = .init()
    let closure: (Event<T>) -> Void

    init(_ closure: @escaping (Event<T>) -> Void) {
        self.closure = closure
    }

    static func == (lhs: EquatableEventClosure, rhs: EquatableEventClosure) -> Bool {
        lhs.id == rhs.id
    }
}
