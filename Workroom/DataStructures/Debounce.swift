//
//  Debounce.swift
//  DataStructures
//
//  Created by Bohdan Savych on 30/06/2024.
//

import Foundation

/// Returns function that will call parameter function `f` no more than once during `timeInterval`
func debounce(timeInterval: DispatchTimeInterval, _ f: @escaping () -> Void) -> (() -> Void) {
    var lastCall: DispatchTime?
    return {
        if let unwrappedLastCall = lastCall {
            let diff = (DispatchTime.now().uptimeNanoseconds - unwrappedLastCall.uptimeNanoseconds)
//            print("debug:: diff \(diff)")// NOLINT no_nslog_swift
            switch timeInterval {
            case .milliseconds(let milliseconds):
                if Double(diff) >= Double(milliseconds) * 1_000_000 {
                    f()
                    lastCall = DispatchTime.now()
//                    print("debug:: lastCall \(lastCall)")// NOLINT no_nslog_swift
                }
                
            case .seconds(let seconds):
                if Double(diff) >= Double(seconds) * 1_000_000_000 {
                    f()
                    lastCall = DispatchTime.now()
//                    print("debug:: lastCall \(lastCall)")// NOLINT no_nslog_swift
                }
            case .nanoseconds(let nanoseconds):
                if diff >= nanoseconds {
                    f()
                    lastCall = DispatchTime.now()
//                    print("debug:: lastCall \(lastCall)")// NOLINT no_nslog_swift
                }

            case .microseconds(let microseconds):
                if Double(diff) >= Double(microseconds) * 1_000 {
                    f()
                    lastCall = DispatchTime.now()
//                    print("debug:: lastCall \(lastCall)")// NOLINT no_nslog_swift
                }
            case .never:
                break
            @unknown default:
                break
            }
        } else {
            f()
            lastCall = DispatchTime.now()
//            print("debug:: lastCall \(lastCall)")// NOLINT no_nslog_swift
        }
    }
}
