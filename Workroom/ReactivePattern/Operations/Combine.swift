//
//  Combine.swift
//  ReactivePattern
//
//  Created by Bohdan Savych on 01/05/2024.
//

import Foundation

func combineLatest<A, B, C>(_ obs1: ObservableSequence<A>, obs2: ObservableSequence<B>, obs3: ObservableSequence<C>) -> ObservableSequence<(A, B, C)> {
    obs1.flatMapLatest { v1 in
        obs2.flatMapLatest { v2 in
            obs3.map { (v1, v2, $0) }
        }
    }
}

extension Observable {
    func combineLatest<A, B>(with obs1: ObservableSequence<A>, obs2: ObservableSequence<B>) -> ObservableSequence<(Value, A, B)> {
        ReactivePattern.combineLatest(self.toObservable(), obs2: obs1, obs3: obs2)
    }
}
