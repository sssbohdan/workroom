//
//  BigIntWithOverlows.swift
//  BigInt
//
//  Created by Bohdan Savych on 02/10/2022.
//

import Foundation

// TODO: Make it work for negative Integers
enum BigInt {
    static func addition(lhs: String, rhs: String) -> String {
        if lhs == "0" { return rhs }
        if rhs == "0" { return lhs }
        
        var lhs = lhs
        var rhs = rhs
        
        if lhs.count < rhs.count {
            lhs = String(repeating: "0", count: rhs.count - lhs.count) + lhs
        } else if lhs.count > rhs.count {
            rhs = String(repeating: "0", count: lhs.count - rhs.count) + rhs
        }
        
        var movedToNext = 0
        var acc = ""
        for pair in zip(lhs.reversed(), rhs.reversed()) {
            let lhsDigit = Int(String(pair.0))!
            let rhsDigit = Int(String(pair.1))!
            let sum = (lhsDigit + rhsDigit + movedToNext)
            let lastDigit = sum % 10
            movedToNext = sum / 10
            acc = "\(lastDigit)" + acc
        }
        
        return movedToNext == 0 ? acc : "\(movedToNext)" + acc
    }
    
    static func substraction(lhs: String, rhs: String) -> String {
        return ""
    }
    
    static func multiplication(lhs: String, rhs: String) -> String {
        let lhs = Array(String(lhs.reversed()))
        let rhs = Array(String(rhs.reversed()))
        
        var totalAcc = "0"
        for (index, l) in lhs.enumerated() {
            var movedToNext = 0
            var acc = String(repeating: "0", count: index)
            for r in rhs {
                let sum = Int(String(r))! * Int(String(l))! + movedToNext
                let lastDigit = sum % 10
                movedToNext = sum / 10
                acc = "\(lastDigit)" + acc
            }
            
            acc = movedToNext == 0 ? acc : "\(movedToNext)" + acc
            
            totalAcc = Self.addition(lhs: totalAcc, rhs: acc)
        }
        return totalAcc
    }
    
    //    static func division(lhs: String, rhs: String) -> String {
    //        guard BigInt.isOverflownInteger(lhs) else {
    //            if BigInt.isOverflownInteger(rhs) {
    //                return "0"
    //            } else {
    //                return String(Int(lhs)! / Int(rhs)!)
    //            }
    //        }
    //
    //        var start = 0
    //        var end = 0
    //        let arrayLhs = Array(lhs)
    //
    //        while true {
    //            if String(Array(arrayLhs[start...end]))
    //        }
    //
    //        return ""
    //    }
    
    static func factorial(_ n: Int) -> String {
        guard n >= 2 else { return "1" }
        var acc = "1"
        for x in 2...n {
            acc = Self.multiplication(lhs: acc, rhs: "\(x)")
        }
        
        return acc
    }
    
    static func isOverflownInteger(_ value: String) -> Bool {
        let stringIntMax = String(Int.max)
        if stringIntMax.count > value.count  {
            return false
        } else if stringIntMax.count == value.count {
            return value > stringIntMax
        } else {
            return true
        }
    }
}
