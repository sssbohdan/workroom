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
    func testaddition() {
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
}
