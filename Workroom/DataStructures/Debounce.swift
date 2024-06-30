//
//  Debounce.swift
//  DataStructures
//
//  Created by Bohdan Savych on 30/06/2024.
//

import Foundation

/// Returns function that will call parameter function `f` no more than once during `timeInterval`
func debounce(timeInterval: DispatchTimeInterval, _ f: @escaping () -> Void) -> (() -> Void) {
    var lastCall: TimeInterval? // FIXME: Use more precise API
    return {
        if let unwrappedLastCall = lastCall {
            let diff = (Date().timeIntervalSinceReferenceDate - unwrappedLastCall)
            
            switch timeInterval {
            case .milliseconds(let milliseconds):
                if diff >= Double(milliseconds) / 1000 {
                    f()
                    lastCall = Date().timeIntervalSinceReferenceDate
                }
                
            case .seconds(let seconds):
                if diff >= Double(seconds) {
                    f()
                    lastCall = Date().timeIntervalSinceReferenceDate
                }
            case .nanoseconds(let nanoseconds):
                if diff >= Double(nanoseconds) / 1_000_000_000 {
                    f()
                    lastCall = Date().timeIntervalSinceReferenceDate
                }
                
            case .microseconds(let microseconds):
                if diff >= Double(microseconds) / 1_000_000 {
                    f()
                    lastCall = Date().timeIntervalSinceReferenceDate
                }
            case .never:
                break
            @unknown default:
                break
            }
        } else {
            f()
            lastCall = Date().timeIntervalSinceReferenceDate
        }
    }
}
