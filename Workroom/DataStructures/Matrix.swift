//
//  Matrix.swift
//
//  Created by Bohdan Savych on 26/07/2023.
//

import Foundation

//1 2 3
//4 5 6
//7 8 9
// (2) -> row 0 column 1
// (7) -> row 2 column 9


struct Matrix<T> {
    fileprivate var values: [T]
    let rows: Int
    let columns: Int
    
    init(repeating object: T, rows: Int, columns: Int) {
        self.values = Array(repeating: object, count: rows * columns)
        self.columns = columns
        self.rows = rows
    }
    
    @inline(__always)
    fileprivate func pointToIndex(_ point: Point) -> Int {
        (point.row * self.columns) + point.column
    }
    
    @inline(__always)
    fileprivate func indexToPoint(index: Int) -> Point {
        let row = index / self.columns
        let column = index % self.columns
        
        return Point(row: row, column: column)
    }
    
    func row(at index: Int) -> [T] {
        let offset = index * columns
        return Array(self.values[offset...(offset + columns - 1)])
    }
    
    func column(at index: Int) -> [T] {
        var arr = [T]()
        for row in 0..<rows {
            arr.append(self[row, index])
        }
        
        return arr
    }
}

extension Matrix: Codable where T: Codable {}

extension Matrix: Equatable where T: Equatable {}

extension Matrix: Hashable where T: Hashable {}


// MARK: - Point
struct Point: Equatable, Comparable {
    static func < (lhs: Point, rhs: Point) -> Bool {
        if lhs.row < rhs.row { return true }
        else if lhs.row > rhs.row { return false }
        else { return lhs.column < rhs.column }
    }
    
    let row: Int
    let column: Int
}


// MARK: - RandomAccessCollection
extension Matrix: RandomAccessCollection {
    
    subscript(position: Point) -> T {
        get {
            let index = self.pointToIndex(position)
            return self.values[index]
        } set {
            let index = self.pointToIndex(position)
            self.values[index] = newValue
        }
    }
    
    subscript(row: Int, column: Int) -> T {
        get {
            let index = self.pointToIndex(Point(row: row, column: column))
            return self.values[index]
        } set {
            let index = self.pointToIndex(Point(row: row, column: column))
            self.values[index] = newValue
        }
    }
    
    subscript(index: Int) -> T {
        get {
            self.values[index]
        } set {
            self.values[index] = newValue
        }
    }
    
    var startIndex: Point {
        .init(row: 0, column: 0)
    }
    
    var endIndex: Point {
        .init(row: self.rows - 1, column: self.columns - 1)
    }
    
    func index(before i: Point) -> Point {
        let index = self.pointToIndex(i)
        
        return self.indexToPoint(index: index - 1)
    }
    
    func index(after i: Point) -> Point {
        let index = self.pointToIndex(i)
        
        return self.indexToPoint(index: index + 1)
    }
    
    struct MatrixIterator<T>: IteratorProtocol {
        private var count = 0
        let matrix: Matrix<T>
        
        init(matrix: Matrix<T>) {
            self.matrix = matrix
        }
        
        mutating func next() -> T? {
            guard self.count < self.matrix.values.count else { return nil }
            
            defer { self.count += 1 }
            return self.matrix.values[self.count]
        }
    }
    
    func makeIterator() -> MatrixIterator<T> {
        return MatrixIterator(matrix: self)
    }
}

// MARK: - Public
extension Matrix {
    func toArray() -> [T] {
        self.values
    }
}
