//
//  Disposable.swift
//  Algorithms
//
//  Created by Bohdan Savych on 04/11/2022.
//

import Foundation

protocol Disposable {
    func dispose()
}

final class EmptyDisposable: Disposable {
    func dispose() {}
}

final class BlockDisposable: Disposable {
    private var closure: (() -> Void)?

    init(closure: (() -> Void)?) {
        self.closure = closure
    }

    func dispose() {
        self.closure?()
        self.closure = nil
    }
}

final class DisposeBag {
    fileprivate var disposables = [Disposable]()

    deinit {
        self.disposables.forEach { $0.dispose() }
        self.disposables = []
    }
}

extension Disposable {
    func dispose(in bag: DisposeBag) {
        bag.disposables.append(self)
    }
}
