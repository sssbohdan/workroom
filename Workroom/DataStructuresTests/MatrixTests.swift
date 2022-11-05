//
//  MatrixTests.swift
//  SudokuSolverTests
//
//  Created by Bohdan Savych on 21/4/22.
//

@testable import DataStructures
import XCTest

final class MatrixTests: XCTestCase {
  func testForLoop() {
    let matrix = Matrix<Int>.init(repeating: 0, rows: 5, columns: 5)
    var valuesCount = 0
    for value in matrix {
      XCTAssertEqual(value, 0)
      valuesCount += 1
    }
    
    XCTAssertEqual(valuesCount, matrix.columns * matrix.rows)
  }
  
  func testMatrixGetSet() {
    var matrix = Matrix<Int>.init(repeating: 0, rows: 5, columns: 5)

    var acc = 1
    for i in 0..<matrix.rows {
      for j in 0..<matrix.columns {
        matrix[i, j] = acc
        XCTAssertEqual(matrix[i, j], acc)
        XCTAssertEqual(matrix[Point(row: i, column: j)], acc)
        acc += 1
        matrix[Point(row: i, column: j)] = acc
        XCTAssertEqual(matrix[i, j], acc)
        XCTAssertEqual(matrix[Point(row: i, column: j)], acc)
      }
    }
    
    acc = 2
    for value in matrix {
      XCTAssertEqual(acc, value)
      acc += 1
    }
  }
  
  func testIndexOffsetBy() {
    let matrix = Matrix<Int>.init(repeating: 0, rows: 5, columns: 5)
    let negativeIndex = matrix.index(matrix.startIndex, offsetBy: -1, limitedBy: matrix.startIndex)
    XCTAssertNil(negativeIndex)
    let overflownIndex = matrix.index(matrix.startIndex, offsetBy: 100, limitedBy: matrix.endIndex)
    XCTAssertNil(overflownIndex)
    XCTAssertEqual(matrix.index(before: .init(row: 1, column: 0)), Point(row: 0, column: 4))
    XCTAssertEqual(matrix.index(after: .init(row: 1, column: 0)), Point(row: 1, column: 1))
    XCTAssertEqual(matrix.index(before: .init(row: 3, column: 3)), Point(row: 3, column: 2))
    XCTAssertEqual(matrix.index(after: .init(row: 1, column: 4)), Point(row: 2, column: 0))
  }

    func testGetRowColumn() {
        var matrix = Matrix<Int>.init(repeating: 0, rows: 3, columns: 3)

        var acc = 0
        for i in 0..<matrix.rows {
            for j in 0..<matrix.columns {
                matrix[i, j] = acc
                acc += 1
            }
        }

        let firstRow = matrix.row(at: 0)
        XCTAssertEqual(firstRow, [0, 1, 2])
        let secondRow = matrix.row(at: 1)
        XCTAssertEqual(secondRow, [3, 4, 5])
        let thirdRow = matrix.row(at: 2)
        XCTAssertEqual(thirdRow, [6, 7, 8])
        let firstColumn = matrix.column(at: 0)
        XCTAssertEqual(firstColumn, [0, 3, 6])
        let secondColumn = matrix.column(at: 1)
        XCTAssertEqual(secondColumn, [1, 4, 7])
        let thirdColumn = matrix.column(at: 2)
        XCTAssertEqual(thirdColumn, [2, 5, 8])
    }
}
