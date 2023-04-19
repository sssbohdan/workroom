//
//  BigIntWithOverlows.swift
//  BigInt
//
//  Created by Bohdan Savych on 02/10/2022.
//

import Foundation

struct BigInt {
    let string: String
    
    init?(string: String) {
        var stringWithoutSpaces = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let digitsCharacters = Array("0123456789")
        let isNegative = stringWithoutSpaces.first == "-"
        stringWithoutSpaces = isNegative
        ? String(stringWithoutSpaces.dropFirst())
        : stringWithoutSpaces
        
        for char in stringWithoutSpaces {
            if stringWithoutSpaces.first == "0" {
                stringWithoutSpaces = String(stringWithoutSpaces.dropFirst())
            }
            if !digitsCharacters.contains(char) {
                return nil
            }
        }
        self.string = (isNegative && !stringWithoutSpaces.isEmpty ? "-" : "")
        + (stringWithoutSpaces.isEmpty ? "0" : stringWithoutSpaces)
    }
    
    init(int: Int) {
        self.string = "\(int)"
    }
    
    func add(_ value: BigInt) -> BigInt {
        if self.string == "0" { return value }
        if value.string == "0" { return self }
        
        if (self.isNegative && value.isNegative) || (!self.isNegative && !value.isNegative) {
            var lhs = self.abs.string
            var rhs = value.abs.string
            
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
            
            return (self.isNegative && value.isNegative)
            ? BigInt(string: string)!.negate
            : BigInt(string: string)!
        } else {
            return value > self
            ? value.subtract(self.negate)
            : self.subtract(value.negate)
        }
    }
    
    func subtract(_ value: BigInt) -> BigInt {
        guard self != value else { return BigInt(int: 0) }
        guard value != BigInt(int: 0) else { return self }

        if !self.isNegative && value.isNegative {
            return self.add(value.negate)
        } else if self.isNegative && !value.isNegative {
            return self.negate.add(value).negate
        }

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

        return BigInt(string: "\(sign)\(String(Array(acc)[zeroesToSkip..<acc.count]))")!
    }
    
    func multiply(by value: BigInt) -> BigInt {
        let lhs = Array(String(self.abs.string.reversed()))
        let rhs = Array(String(value.abs.string.reversed()))
        
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
            
            totalAcc = BigInt(string: totalAcc)!.add(BigInt(string: acc)!).string
        }

        return (self.isNegative && value.isNegative) || (!self.isNegative && !value.isNegative)
        ? BigInt(string: totalAcc)!
        : BigInt(string: totalAcc)!.negate
    }

    func divide(by value: BigInt) -> BigInt {
        func share(divisible: BigInt, divisor: BigInt) -> Int? {
            for x in 1...10 {
                if BigInt(int: x).multiply(by: divisor) >= divisible {
                    return x - 1
                }
            }

            return nil
        }
        guard value != BigInt(int: 0) else { fatalError("Zero division") }
        guard self != value else { return BigInt(int: 1) }
        guard value.abs < self.abs else { return BigInt(int: 0) }

        let absString = self.abs.string
        var start = 0
        var length = 1
        let selfStringArray = Array(absString)
        var acc = ""
        var remainder = ""
        var moveCounter = 0

        while start + length <= absString.count {
            let substring = remainder + String(selfStringArray[start..<start + length])
            let bigIntSubstring = BigInt(string: substring)!
            if bigIntSubstring.isOverflownInteger {
                if bigIntSubstring >= value.abs {
                    moveCounter = 0
                    var digit = share(divisible: bigIntSubstring, divisor: value.abs)!
                    let diff = bigIntSubstring.subtract(BigInt(int: digit).multiply(by: value.abs))
                    remainder = diff.string
                    if diff == value.abs {
                        digit += 1
                        remainder = ""
                    }
                    acc.append("\(digit)")
                    start = start + length
                    length = 1
                } else {
                    moveCounter += 1
                    length += 1
                    if !remainder.isEmpty && moveCounter >= 1 {
                        acc.append("0")
                    }
                }
            } else {
                if value.abs > bigIntSubstring {
                    length += 1
                    moveCounter += 1
                    if !remainder.isEmpty && moveCounter >= 1 {
                        acc.append("0")
                    }
                } else {
                    moveCounter = 0
                    // perform division
                    let v = Int(substring)! / Int(value.abs.string)!
                    acc.append("\(v)")
                    remainder = "\(Int(substring)! % Int(value.abs.string)!)"
                    start = start + length
                    length = 1
                }
            }
        }

        return  (self.isNegative && value.isNegative) || (!self.isNegative && !value.isNegative)
        ? BigInt(string: acc)!
        : BigInt(string: acc)!.negate
    }
    
    static func factorial(of n: Int) -> BigInt {
        guard n >= 2 else { return BigInt(string: "1")! }
        var acc = "1"
        for x in 2...n {
            acc = BigInt(string: acc)!.multiply(by: BigInt(string: "\(x)")!).string
        }
        
        return BigInt(string: acc)!
    }
    
    var isOverflownInteger: Bool {
        self > BigInt(int: Int.max)
    }

    var abs: BigInt {
        self.isNegative
        ? BigInt(string: String(string.dropFirst()))!
        : self
    }

    var negate: BigInt {
        self.isNegative
        ? BigInt(string: String(string.dropFirst()))!
        : BigInt(string: "-" + string)!
    }

    var isNegative: Bool {
        string.first == "-"
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
        if lhs.isNegative && !rhs.isNegative {
            return true
        } else if !lhs.isNegative && rhs.isNegative {
            return false
        } else {
            if lhs.string.count < rhs.string.count  {
                return lhs.isNegative ? false : true
            } else if lhs.string.count == rhs.string.count {
                return lhs.isNegative ? lhs.string > rhs.string : lhs.string < rhs.string
            } else {
                return lhs.isNegative ? true : false
            }
        }
    }

    static func min(_ lhs: BigInt, _ rhs: BigInt) -> BigInt {
        lhs < rhs ? lhs : rhs
    }

    static func max(_ lhs: BigInt, _ rhs: BigInt) -> BigInt {
        lhs > rhs ? lhs : rhs
    }
}

// MARK: - CustomStringConvertible
extension BigInt: CustomStringConvertible {
    var description: String { self.string }
}

extension Optional where Wrapped == BigInt {
    var orZero: BigInt { self == nil ? BigInt(int: 0) : self! }
}
