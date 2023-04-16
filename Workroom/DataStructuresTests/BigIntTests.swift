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
        XCTAssertEqual("13", BigInt(string: "1").add(BigInt(string: "12")).string)
        XCTAssertEqual("13", BigInt(string: "12").add(BigInt(string: "1")).string)
        XCTAssertEqual("10", BigInt(string: "5").add(BigInt(string: "5")).string)
        XCTAssertEqual("120", BigInt(string: "10").add(BigInt(string: "110")).string)
        XCTAssertEqual("36893488147419103232", BigInt(string: "18446744073709551616").add(BigInt(string: "18446744073709551616")).string)

        XCTAssertEqual(
            "99388628287564574658559713462294177594028508522049222183377604945437589674921151",
            BigInt(
                string: "3689348814741910323232187381273812738127318237128371283712837128371283712839"
            )
            .add(
                BigInt(string: "99384938938749832748236481274912903781290381203812093812093892108309218391208312")).string
        )
    }

    func testSubtraction() {
        XCTAssertEqual("0", BigInt(string: "100").subtract(BigInt(string: "100")).string)
        XCTAssertEqual("-100", BigInt(string: "0").subtract(BigInt(string: "100")).string)
        XCTAssertEqual("10", BigInt(string: "110").subtract(BigInt(string: "100")).string)
        XCTAssertEqual(
            "99384938938749832748236481274912903781290381203812093812093892108309218391208312",
            BigInt(string: "99388628287564574658559713462294177594028508522049222183377604945437589674921151")
                .subtract(
                    BigInt(string: "3689348814741910323232187381273812738127318237128371283712837128371283712839")
                ).string
        )
        XCTAssertEqual(
            "-99384938938749832748236481274912903781290381203812093812093892108309218391208312",
            BigInt(string: "3689348814741910323232187381273812738127318237128371283712837128371283712839")
                .subtract(
                    BigInt(string: "99388628287564574658559713462294177594028508522049222183377604945437589674921151")
                ).string
        )
    }

    func testAbs() {
        XCTAssertEqual(BigInt(string: "100"), BigInt(string: "-100").abs)
        XCTAssertEqual(BigInt(string: "100"), BigInt(string: "100").abs)
    }

    func testMultiplications() {
        XCTAssertEqual("12", BigInt(string: "1").multiply(by: BigInt(string: "12")).string)
        XCTAssertEqual("25", BigInt(string: "5").multiply(by: BigInt(string: "5")).string)
        XCTAssertEqual("1100", BigInt(string: "10").multiply(by: BigInt(string: "110")).string)
        XCTAssertEqual(
            "340282366920938463463374607431768211456",
            BigInt(string: "18446744073709551616").multiply(by: BigInt(string: "18446744073709551616")).string
        )
        
        XCTAssertEqual(
            "366665706676873826264863717123819340361290349705643824284510724943347649088950282263745334756929992275939422380330698197066356568465337702785860474837917768",
            BigInt(
                string: "3689348814741910323232187381273812738127318237128371283712837128371283712839"
            ).multiply(
                by: BigInt(string: "99384938938749832748236481274912903781290381203812093812093892108309218391208312")
            ).string
        )
    }

    func testDivision() {
        XCTAssertEqual("1", BigInt(string: "2").divide(by: BigInt(string: "2")).string)
        XCTAssertEqual("0", BigInt(string: "2").divide(by: BigInt(string: "3")).string)
        XCTAssertEqual("5", BigInt(string: "10").divide(by: BigInt(string: "2")).string)
        XCTAssertEqual("234", BigInt(string: "468").divide(by: BigInt(string: "2")).string)
        XCTAssertEqual("13", BigInt(string: "468").divide(by: BigInt(string: "36")).string)
        XCTAssertEqual("15", BigInt(string: "468").divide(by: BigInt(string: "30")).string)
        XCTAssertEqual("102", BigInt(string: "55080").divide(by: BigInt(string: "540")).string)

        XCTAssertEqual("2", BigInt(string: "3689348814741910323232187381273812738127318237128371283712837128371283712838")
            .divide(by: BigInt(string: "1844674407370955161616093690636906369063659118564185641856418564185641856419")).string)
        XCTAssertEqual("1", BigInt(string: "3689348814741910323232187381273812738127318237128371283712837128371283712838")
            .divide(by: BigInt(string: "1844674407370955161616093690636906369063659118564185641856418564185641856420")).string)
        XCTAssertEqual("2", BigInt(string: "3689348814741910323232187381273812738127318237128371283712837128371283712838")
            .divide(by: BigInt(string: "1844674407370955161616093690636906369063659118564185641856418564185641856400")).string)
        XCTAssertEqual(
            "1844674407370955161616093690636906369063659118564185641856418564185641856419",
            BigInt(string: "6805647338418769269386242625587551214232448169147075892837021281507840117047172611791093817465194801958393915682474202972326638755542446973385223007122")
                .divide(
                    by: BigInt(string: "3689348814741910323232187381273812738127318237128371283712837128371283712838")
                ).string
        )
    }

    func testFactorial() {
        XCTAssertEqual(BigInt.factorial(of: 0).string, "1")
        XCTAssertEqual(BigInt.factorial(of: 1).string, "1")
        XCTAssertEqual(BigInt.factorial(of: 2).string, "2")
        XCTAssertEqual(BigInt.factorial(of: 3).string, "6")
        XCTAssertEqual(BigInt.factorial(of: 4).string, "24")
        XCTAssertEqual(BigInt.factorial(of: 5).string, "120")
        XCTAssertEqual(BigInt.factorial(of: 6).string, "720")
        XCTAssertEqual(BigInt.factorial(of: 7).string, "5040")
        XCTAssertEqual(BigInt.factorial(of: 8).string, "40320")
        XCTAssertEqual(BigInt.factorial(of: 9).string, "362880")
        XCTAssertEqual(BigInt.factorial(of: 10).string, "3628800")
        XCTAssertEqual(BigInt.factorial(of: 11).string, "39916800")
        XCTAssertEqual(BigInt.factorial(of: 12).string, "479001600")
        XCTAssertEqual(BigInt.factorial(of: 13).string, "6227020800")
        XCTAssertEqual(BigInt.factorial(of: 14).string, "87178291200")
        XCTAssertEqual(BigInt.factorial(of: 15).string, "1307674368000")
        XCTAssertEqual(BigInt.factorial(of: 16).string, "20922789888000")
        XCTAssertEqual(BigInt.factorial(of: 17).string, "355687428096000")
        XCTAssertEqual(BigInt.factorial(of: 18).string, "6402373705728000")
        XCTAssertEqual(BigInt.factorial(of: 19).string, "121645100408832000")
        XCTAssertEqual(BigInt.factorial(of: 20).string, "2432902008176640000")
        XCTAssertEqual(BigInt.factorial(of: 21).string, "51090942171709440000")
        XCTAssertEqual(BigInt.factorial(of: 22).string, "1124000727777607680000")
        XCTAssertEqual(BigInt.factorial(of: 23).string, "25852016738884976640000")
        XCTAssertEqual(BigInt.factorial(of: 24).string, "620448401733239439360000")
        XCTAssertEqual(BigInt.factorial(of: 25).string, "15511210043330985984000000")
        XCTAssertEqual(BigInt.factorial(of: 26).string, "403291461126605635584000000")
        XCTAssertEqual(BigInt.factorial(of: 27).string, "10888869450418352160768000000")
        XCTAssertEqual(BigInt.factorial(of: 28).string, "304888344611713860501504000000")
        XCTAssertEqual(BigInt.factorial(of: 29).string, "8841761993739701954543616000000")
        XCTAssertEqual(BigInt.factorial(of: 30).string, "265252859812191058636308480000000")
    }

    func testIsOverflownInteger() {
        XCTAssertFalse(BigInt(string: "1").isOverflownInteger)
        XCTAssertFalse(BigInt(string: "\(Int.max)").isOverflownInteger)
        XCTAssertTrue(BigInt(string: "\(Int.max)1").isOverflownInteger)
        XCTAssertFalse(BigInt(string: "0").isOverflownInteger)
        XCTAssertFalse(BigInt(string: "-1").isOverflownInteger)
        XCTAssertTrue(BigInt(string: String(Array(repeating: "9", count: String(Int.max).count))).isOverflownInteger)
    }
}
