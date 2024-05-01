//
//  FlatMap.swift
//  ReactivePattern
//
//  Created by Bohdan Savych on 30/04/2024.
//

import Foundation

extension Observable {
    func flatMap<NewType>(_ f: @escaping ((Value) -> ObservableSequence<NewType>)) -> ObservableSequence<NewType> {
        return ObservableSequence<NewType> { producer in
            let bag = DisposeBag()
            self.observe { event in
                switch event {
                case .failure(let error):
                    producer(.failure(error))
                case .completed:
                    producer(.completed)
                case .next(let value):
                    let observable = f(value)
                    let disposable = observable.observe { internalEvent in
                        producer(internalEvent)
                    }
                    bag.add(disposable)
                }
            }
            .dispose(in: bag)

            return bag
        }
    }

    func flatMapLatest<NewType>(_ f: @escaping ((Value) -> ObservableSequence<NewType>)) -> ObservableSequence<NewType> {
        return ObservableSequence<NewType> { producer in
            let bag = DisposeBag()
            var latestDisposable: Disposable?
            self.observe { event in
                latestDisposable?.dispose()
                switch event {
                case .failure(let error):
                    producer(.failure(error))
                case .completed:
                    producer(.completed)
                case .next(let value):
                    let observable = f(value)
                    let disposable = observable.observe { internalEvent in
                        producer(internalEvent)
                    }
                    latestDisposable = disposable
                    bag.add(disposable)
                }
            }
            .dispose(in: bag)

            return bag
        }
    }
}
