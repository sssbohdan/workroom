//
//  MD2.swift
//  Algorithms
//
//  Created by Bohdan Savych on 15/12/2024.
//

import Foundation

enum MD2 {
    // Pi decimals
    private static let S: [UInt8] = [
        41, 46, 67, 201, 162, 216, 124, 1, 61, 54, 84, 161, 236, 240, 6, 19,
        98, 167, 5, 243, 192, 199, 115, 140, 152, 147, 43, 217, 188, 76, 130, 202,
        30, 155, 87, 60, 253, 212, 224, 22, 103, 66, 111, 24, 138, 23, 229, 18,
        190, 78, 196, 214, 218, 158, 222, 73, 160, 251, 245, 142, 187, 47, 238, 122,
        169, 104, 121, 145, 21, 178, 7, 63, 148, 194, 16, 137, 11, 34, 95, 33,
        128, 127, 93, 154, 90, 144, 50, 39, 53, 62, 204, 231, 191, 247, 151, 3,
        255, 25, 48, 179, 72, 165, 181, 209, 215, 94, 146, 42, 172, 86, 170, 198,
        79, 184, 56, 210, 150, 164, 125, 182, 118, 252, 107, 226, 156, 116, 4, 241,
        69, 157, 112, 89, 100, 113, 135, 32, 134, 91, 207, 101, 230, 45, 168, 2,
        27, 96, 37, 173, 174, 176, 185, 246, 28, 70, 97, 105, 52, 64, 126, 15,
        85, 71, 163, 35, 221, 81, 175, 58, 195, 92, 249, 206, 186, 197, 234, 38,
        44, 83, 13, 110, 133, 40, 132, 9, 211, 223, 205, 244, 65, 129, 77, 82,
        106, 220, 55, 200, 108, 193, 171, 250, 36, 225, 123, 8, 12, 189, 177, 74,
        120, 136, 149, 139, 227, 99, 232, 109, 233, 203, 213, 254, 59, 0, 29, 57,
        242, 239, 183, 14, 102, 88, 208, 228, 166, 119, 114, 248, 235, 117, 75, 10,
        49, 68, 80, 180, 143, 237, 31, 26, 219, 153, 141, 51, 159, 17, 131, 20
    ]
    static let blockSize = 16

    static func hash(_ string: String) -> String {
        guard let inputData = string.data(using: .utf8) else {
            fatalError("Unable to convert input string to UTF-8 Data")
        }
        return hash(data: inputData).map { String(format: "%02x", $0) }.joined()
    }

    private static func hash(data: Data) -> Data {
        var paddedData = data
        let paddingLength = blockSize - (data.count % blockSize)
        let padding = [UInt8](repeating: UInt8(paddingLength), count: paddingLength)
        paddedData.append(contentsOf: padding)

        // 1) Compute the 16-byte checksum of all blocks (MD2 Checksum step)
        var checksum = [UInt8](repeating: 0, count: 16)
        var L: UInt8 = 0
        for blockStart in stride(from: 0, to: paddedData.count, by: 16) {
            let blockBytes = [UInt8](paddedData[blockStart..<blockStart + 16])
            L = checksum[15]  // L is cksum[15] from the previous block
            for i in 0..<16 {
                let c = blockBytes[i] ^ L
                L = checksum[i] ^ S[Int(c)]
                checksum[i] = L
            }
        }
        // Append the 16-byte checksum
        paddedData.append(contentsOf: checksum)

        // 2) Initialize the 48-byte state to 0
        var state = [UInt8](repeating: 0, count: 48)

        // 3) For each 16-byte block (including the appended checksum), do the MD2 transform
        for blockStart in stride(from: 0, to: paddedData.count, by: 16) {
            let blockBytes = [UInt8](paddedData[blockStart..<blockStart + 16])

            // Load block into X[16..31], XOR X[0..15] into X[32..47]
            for i in 0..<16 {
                state[16 + i] = blockBytes[i]
                state[32 + i] = state[16 + i] ^ state[i]
            }

            var t: UInt8 = 0
            for round in 0..<18 {
                for i in 0..<48 {
                    t = state[i] ^ S[Int(t)]
                    state[i] = t
                }
                t = (t &+ UInt8(round)) & 0xff
            }
        }

        // The first 16 bytes of 'state' is the final digest
        return Data(state[0..<16])
    }
}
