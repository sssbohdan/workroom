//
//  DITests.swift
//  SudokuSolverTests
//
//  Created by Bohdan Savych on 29/5/22.
//

@testable import Architecture

import Foundation
import XCTest

final class DITests: XCTestCase {
  
  func testRegisterResolveNoParams() {
    let di = DI()
    di.register(object: { "Test" }, in: .new)
    let resolvedObject = di.resolve(type: String.self)
    XCTAssertEqual(resolvedObject, "Test")
    
    di.register(object: { "Another test" }, in: .new)
    let newResolvedObject = di.resolve(type: String.self)
    XCTAssertEqual(newResolvedObject, "Another test")
  }
  
  func testRegisterResolve1Param() {
    let di = DI()
    di.register(object: { (int: Int) in String(int) }, in: .new)
    let resolvedObject = di.resolve(type: String.self, param: 10)
    XCTAssertEqual(resolvedObject, "10")
  }
  
  func testRegisterResolve2Params() {
    let di = DI()
    let params: (Character, Int) = ("a", 10)
    di.register(
      object: { (char: Character, count: Int) in String(repeating: char, count: count) },
      in: .new)
    let resolvedObject = di.resolve(type: String.self, params: params)
    XCTAssertEqual(resolvedObject, "aaaaaaaaaa")
  }
  
  func testRegisterResolve3Params() {
    let di = DI()
    let params: (CGFloat, CGFloat, CGFloat) = (10, 10, 10)
    di.register(
      object: { (a: CGFloat, b: CGFloat, c: CGFloat) in
      CATransform3DMakeScale(a, b, c) },
      in: .new)
    let resolvedObject = di.resolve(type: CATransform3D.self, params: params)
    XCTAssertEqual(resolvedObject.m11, CATransform3DMakeScale(10, 10, 10).m11)
    XCTAssertEqual(resolvedObject.m33, CATransform3DMakeScale(10, 10, 10).m33)
    XCTAssertEqual(resolvedObject.m22, CATransform3DMakeScale(10, 10, 10).m22)
  }
  
  func testSingletonScope() {
    let di = DI()
    let object = UIView()

    di.register(object: { object }, in: .singleton)
    
    let resolved1 = di.resolve(type: UIView.self)
    let resolved2 = di.resolve(type: UIView.self)

    XCTAssert(resolved1 === resolved2)
  }
}
