//
//  Map.swift
//  ReactivePattern
//
//  Created by Bohdan Savych on 06/11/2022.
//

import Foundation

extension Observable {
    func map<NewType>(_ f: @escaping (Value) -> NewType) -> ObservableSequence<NewType> {
        return ObservableSequence { producer in
            return self.observe { event in
                producer(event.map(f))
            }
        }
    }
}
