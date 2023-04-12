//
//  BigIntTests.swift
//  BigIntTests
//
//  Created by Bohdan Savych on 02/10/2022.
//

import Foundation
import XCTest

@testable import DataStructures

final class BigIntTests: XCTestCase {
    func testAddition() {
        XCTAssertEqual("13", BigInt.addition(lhs: "1", rhs: "12"))
        XCTAssertEqual("10", BigInt.addition(lhs: "5", rhs: "5"))
        XCTAssertEqual("120", BigInt.addition(lhs: "10", rhs: "110"))
        XCTAssertEqual("36893488147419103232", BigInt.addition(lhs: "18446744073709551616", rhs: "18446744073709551616"))

        XCTAssertEqual(
            "99388628287564574658559713462294177594028508522049222183377604945437589674921151",
            BigInt.addition(
                lhs: "3689348814741910323232187381273812738127318237128371283712837128371283712839",
                rhs: "99384938938749832748236481274912903781290381203812093812093892108309218391208312"
            )
        )
    }

    func testMultiplyNumberStrings() {
        XCTAssertEqual("12", BigInt.multiplication(lhs: "1", rhs: "12"))
        XCTAssertEqual("25", BigInt.multiplication(lhs: "5", rhs: "5"))
        XCTAssertEqual("1100", BigInt.multiplication(lhs: "10", rhs: "110"))
        XCTAssertEqual(
            "340282366920938463463374607431768211456",
            BigInt.multiplication(
                lhs: "18446744073709551616",
                rhs: "18446744073709551616")
        )
        
        XCTAssertEqual(
            "366665706676873826264863717123819340361290349705643824284510724943347649088950282263745334756929992275939422380330698197066356568465337702785860474837917768",
            BigInt.multiplication(
                lhs: "3689348814741910323232187381273812738127318237128371283712837128371283712839",
                rhs: "99384938938749832748236481274912903781290381203812093812093892108309218391208312"
            )
        )
    }

    func testFactorial() {
        XCTAssertEqual(BigInt.factorial(0), "1")
        XCTAssertEqual(BigInt.factorial(1), "1")
        XCTAssertEqual(BigInt.factorial(2), "2")
        XCTAssertEqual(BigInt.factorial(3), "6")
        XCTAssertEqual(BigInt.factorial(4), "24")
        XCTAssertEqual(BigInt.factorial(5), "120")
        XCTAssertEqual(BigInt.factorial(6), "720")
        XCTAssertEqual(BigInt.factorial(7), "5040")
        XCTAssertEqual(BigInt.factorial(8), "40320")
        XCTAssertEqual(BigInt.factorial(9), "362880")
        XCTAssertEqual(BigInt.factorial(10), "3628800")
        XCTAssertEqual(BigInt.factorial(11), "39916800")
        XCTAssertEqual(BigInt.factorial(12), "479001600")
        XCTAssertEqual(BigInt.factorial(13), "6227020800")
        XCTAssertEqual(BigInt.factorial(14), "87178291200")
        XCTAssertEqual(BigInt.factorial(15), "1307674368000")
        XCTAssertEqual(BigInt.factorial(16), "20922789888000")
        XCTAssertEqual(BigInt.factorial(17), "355687428096000")
        XCTAssertEqual(BigInt.factorial(18), "6402373705728000")
        XCTAssertEqual(BigInt.factorial(19), "121645100408832000")
        XCTAssertEqual(BigInt.factorial(20), "2432902008176640000")
        XCTAssertEqual(BigInt.factorial(21), "51090942171709440000")
        XCTAssertEqual(BigInt.factorial(22), "1124000727777607680000")
        XCTAssertEqual(BigInt.factorial(23), "25852016738884976640000")
        XCTAssertEqual(BigInt.factorial(24), "620448401733239439360000")
        XCTAssertEqual(BigInt.factorial(25), "15511210043330985984000000")
        XCTAssertEqual(BigInt.factorial(26), "403291461126605635584000000")
        XCTAssertEqual(BigInt.factorial(27), "10888869450418352160768000000")
        XCTAssertEqual(BigInt.factorial(28), "304888344611713860501504000000")
        XCTAssertEqual(BigInt.factorial(29), "8841761993739701954543616000000")
        XCTAssertEqual(BigInt.factorial(30), "265252859812191058636308480000000")
    }

    func testIsOverflownInteger() {
        XCTAssertFalse(BigInt.isOverflownInteger("1"))
        XCTAssertFalse(BigInt.isOverflownInteger("\(Int.max)"))
        XCTAssertTrue(BigInt.isOverflownInteger("\(Int.max)1"))
        XCTAssertFalse(BigInt.isOverflownInteger("0"))
        XCTAssertFalse(BigInt.isOverflownInteger("-1"))
        XCTAssertTrue(BigInt.isOverflownInteger(String(Array(repeating: "9", count: String(Int.max).count))))
    }
}
