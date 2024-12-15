//
//  BinaryTreeTests.swift
//  DataStructuresTests
//
//  Created by Bohdan Savych on 30/06/2024.
//

import Foundation
import XCTest
@testable import DataStructures

final class BinaryTreeTests: XCTestCase {
    func testInsert() {
        let arr = [1]
        let binaryTree = BinaryTree(array: arr)

        binaryTree.insert(2)
        if 2.hashValue > 1.hashValue {
            XCTAssertEqual(binaryTree.root?.right?.value, [2])
            XCTAssertNil(binaryTree.root?.left)

            binaryTree.insert(3)
            if 3.hashValue < 1.hashValue {
                XCTAssertEqual(binaryTree.root?.left?.value, [3])
            } else if 3.hashValue > 1.hashValue {
                if 3.hashValue < 2.hashValue {
                    XCTAssertEqual(binaryTree.root?.right?.left?.value, [3])
                } else if 3.hashValue > 2.hashValue {
                    XCTAssertEqual(binaryTree.root?.right?.right?.value, [3])
                }
            }
        } else if 2.hashValue < 1.hashValue {
            XCTAssertEqual(binaryTree.root?.left?.value, [2])
            XCTAssertNil(binaryTree.root?.right)

            binaryTree.insert(3)
            if 3.hashValue > 1.hashValue {
                XCTAssertEqual(binaryTree.root?.right?.value, [3])
            } else if 3.hashValue < 1.hashValue {
                if 3.hashValue < 2.hashValue {
                    XCTAssertEqual(binaryTree.root?.left?.left?.value, [3])
                } else if 3.hashValue > 2.hashValue {
                    XCTAssertEqual(binaryTree.root?.left?.right?.value, [3])
                }
            }


        } else {
            XCTAssertEqual(binaryTree.root?.value, [1, 2])
            XCTAssertNil(binaryTree.root?.right)
            XCTAssertNil(binaryTree.root?.left)
        }
    }

    func testInsertSameValue() {
        let arr = [1]
        let binaryTree = BinaryTree(array: arr)
        binaryTree.insert(1)

        XCTAssertEqual(binaryTree.root?.value, [1])
        XCTAssertNil(binaryTree.root?.right)
        XCTAssertNil(binaryTree.root?.left)
    }

    func testContains() {
        let binaryTree = BinaryTree<Int>()
        for digit in 0...1000 {
            binaryTree.insert(digit)
            XCTAssertTrue(binaryTree.contains(digit))
            XCTAssertFalse(binaryTree.contains(digit + 1))
        }
    }
}
