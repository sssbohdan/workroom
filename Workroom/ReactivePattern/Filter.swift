//
//  Filter.swift
//  ReactivePattern
//
//  Created by Bohdan Savych on 06/11/2022.
//

import Foundation

extension ObservableProtocol {
    func filter(_ f: @escaping (Value) -> Bool) -> Observable<Value> {
        return Observable { producer in
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
