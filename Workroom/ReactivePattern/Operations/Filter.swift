//
//  Filter.swift
//  ReactivePattern
//
//  Created by Bohdan Savych on 06/11/2022.
//

import Foundation

extension Observable {
    func filter(_ f: @escaping (Value) -> Bool) -> ObservableSequence<Value> {
        return ObservableSequence { producer in
            return self.observe { event in
                switch event {
                case .next(let value):
                    f(value) ? producer(.next(value)) : ()
                case .failure(let error):
                    producer(.failure(error))
                case .completed:
                    producer(.completed)
                }
            }
        }
    }
}
