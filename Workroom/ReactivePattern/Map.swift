//
//  Map.swift
//  ReactivePattern
//
//  Created by Bohdan Savych on 06/11/2022.
//

import Foundation

extension ObservableProtocol {
    func map<NewType>(_ f: @escaping (Value) -> NewType) -> Observable<NewType> {
        return Observable { producer in
            return self.observe { event in
                producer(event.map(f))
            }
        }
    }
}
