//
//  Throttle.swift
//  DataStructures
//
//  Created by Bohdan Savych on 17/04/2024.
//

import Foundation

/// Returns function that will call parameter function `f` only if `timeInterval` passed without receiving another invokation of that function.
public func throttle(_ f: @escaping () -> Void, timeInterval: DispatchTimeInterval) -> () -> Void {
    var workItem: DispatchWorkItem?
    return {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: f)
        DispatchQueue.main.asyncAfter(
            deadline: .now().advanced(by: timeInterval),
            execute: workItem!)
    }
}

public func throttle<T>(_ f: @escaping (T) -> Void, timeInterval: DispatchTimeInterval) -> (T) -> Void {
    var workItem: DispatchWorkItem?
    return { param1 in
        workItem?.cancel()
        workItem = DispatchWorkItem(block: { f(param1) })
        DispatchQueue.main.asyncAfter(
            deadline: .now().advanced(by: timeInterval),
            execute: workItem!)
    }
}


//
//public func throttle<each Element>(_ f: @escaping (repeat each Element) -> Void, timeInterval: DispatchTimeInterval) -> (repeat each Element) -> Void {
//    var workItem: DispatchWorkItem?
//    return { elements in
//        workItem?.cancel()
//        workItem = DispatchWorkItem { f(elements) }
//        DispatchQueue.main.asyncAfter(
//            deadline: .now().advanced(by: timeInterval),
//            execute: workItem!)
//    }
//}
//
//
