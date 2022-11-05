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
    let closure: () -> Void

    init(closure: @escaping (() -> Void)) {
        self.closure = closure
    }

    func dispose() {
        closure()
    }

    deinit {
        self.dispose()
    }
}
