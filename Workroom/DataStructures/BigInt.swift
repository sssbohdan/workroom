//
//  BigIntWithOverlows.swift
//  BigInt
//
//  Created by Bohdan Savych on 02/10/2022.
//

import Foundation

// TODO: Make it work for negative Integers
struct BigInt {
    let string: String

    init(string: String) {
        self.string = string.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    init(int: Int) {
        self.string = "\(int)"
    }

    func add(_ value: BigInt) -> BigInt {
        if self.string == "0" { return value }
        if value.string == "0" { return self }
        
        var lhs = self.string
        var rhs = value.string
        
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

        let string = movedToNext == 0
        ? acc
        : "\(movedToNext)" + acc

        return BigInt(string: string)
    }
    
    func subtract(_ value: BigInt) -> BigInt {
        guard self != value else { return BigInt(int: 0) }
        let sign = self >= value
        ? ""
        : "-"

        let lhs = BigInt.max(self.abs, value.abs).string
        var rhs = BigInt.min(self.abs, value.abs).string

        if lhs.count > rhs.count {
            rhs = String(repeating: "0", count: lhs.count - rhs.count) + rhs
        }

        var isBorrowingFromNext = false
        var acc = ""
        for pair in zip(lhs.reversed(), rhs.reversed()) {
            var lhsDigit = Int(String(pair.0))!
            let rhsDigit = Int(String(pair.1))!

            if isBorrowingFromNext {
                lhsDigit -= 1
            }

            if lhsDigit < rhsDigit {
                isBorrowingFromNext = true
                lhsDigit += 10
            } else {
                isBorrowingFromNext = false
            }

            let lastDigit = lhsDigit - rhsDigit
            acc = "\(lastDigit)" + acc
        }

        var zeroesToSkip = 0
        for char in Array(acc) {
            if char == "0" {
                zeroesToSkip += 1
            } else {
                break
            }
        }

        return BigInt(string: "\(sign)\(String(Array(acc)[zeroesToSkip..<acc.count]))")
    }
    
    func multiply(by value: BigInt) -> BigInt {
        let lhs = Array(String(self.string.reversed()))
        let rhs = Array(String(value.string.reversed()))
        
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
            
            totalAcc = BigInt(string: totalAcc).add(BigInt(string: acc)).string
        }

        return BigInt(string: totalAcc)
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
    
    static func factorial(of n: Int) -> BigInt {
        guard n >= 2 else { return BigInt(string: "1") }
        var acc = "1"
        for x in 2...n {
            acc = BigInt(string: acc).multiply(by: BigInt(string: "\(x)")).string
        }
        
        return BigInt(string: acc)
    }
    
    var isOverflownInteger: Bool {
        self > BigInt(int: Int.max)
    }

    var abs: BigInt {
        string.first == "-"
        ? BigInt(string: String(string.dropFirst()))
        : self
    }
}

// MARK: - Equatable
extension BigInt: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.string == rhs.string
    }
}

// MARK: - Comparable
extension BigInt: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.string.count < rhs.string.count  {
            return true
        } else if lhs.string.count == rhs.string.count {
            return lhs.string < rhs.string
        } else {
            return false
        }
    }

    static func min(_ lhs: BigInt, _ rhs: BigInt) -> BigInt {
        lhs < rhs ? lhs : rhs
    }

    static func max(_ lhs: BigInt, _ rhs: BigInt) -> BigInt {
        lhs > rhs ? lhs : rhs
    }
}
