
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Testing
import Foundation

struct TestDictionary {

    /* ##################### */
    /* ### MARK: forEach ### */
    /* ##################### */

    static func print_dictMatrix_forEach(source: Dictionary<UInt, String>.Matrix) {
        print("")
        for (y, rows) in source.matrix.ordered() {
            print("y = \(y) | ", terminator: "")
            for (_, value) in rows.ordered() {
                print("\(value) | ", terminator: "")
            }
            print("")
        }
        print("")
    }

    static func print_dictMatrix_forEach_bounds(source: Dictionary<UInt, String>.Matrix) {
        print("")
        if let bounds = source.bounds {
            for y in bounds.minY ... bounds.maxY { print("y = \(y) | ", terminator: "")
            for x in bounds.minX ... bounds.maxX {
                if let value = source[y, x] { print("\(value) | ", terminator: "") }
                else                        { print(     "nil | ", terminator: "") }
            }; print(""); }
        } else {
            print("no data")
        }
        print("")
    }

    /* ######################## */
    /* ### MARK: dictMatrix ### */
    /* ######################## */

    @Test func test_dictMatrix() async throws {

        var dictMatrix: Dictionary<UInt, String>.Matrix
        var expected: [Matrix2dKey.Index: [Matrix2dKey.Index: String]]

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        for rowNum in 0 ..< 3 {
        for colNum in 0 ..< 3 {
            dictMatrix[
                Matrix2dKey.Index(rowNum),
                Matrix2dKey.Index(colNum)
            ] = "\(rowNum):\(colNum)"
        }}

        expected = [
            0: [0: "0:0", 1: "0:1", 2: "0:2"],
            1: [0: "1:0", 1: "1:1", 2: "1:2"],
            2: [0: "2:0", 1: "2:1", 2: "2:2"],
        ]

        Self.print_dictMatrix_forEach       (source: dictMatrix)
        Self.print_dictMatrix_forEach_bounds(source: dictMatrix)
        #expect(dictMatrix.bounds == Dictionary.Matrix.Bounds(minY: 0, maxY: 2, minX: 0, maxX: 2))
        #expect(dictMatrix.matrix == expected)

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        dictMatrix[0, 2] = "0:2"
        expected = [
            0: [2: "0:2"],
        ]
        Self.print_dictMatrix_forEach       (source: dictMatrix)
        Self.print_dictMatrix_forEach_bounds(source: dictMatrix)
        #expect(dictMatrix.bounds == Dictionary.Matrix.Bounds(minY: 0, maxY: 0, minX: 2, maxX: 2))
        #expect(dictMatrix.matrix == expected)

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        dictMatrix[2, 0] = "2:0"
        expected = [
            2: [0: "2:0"]
        ]
        Self.print_dictMatrix_forEach       (source: dictMatrix)
        Self.print_dictMatrix_forEach_bounds(source: dictMatrix)
        #expect(dictMatrix.bounds == Dictionary.Matrix.Bounds(minY: 2, maxY: 2, minX: 0, maxX: 0))
        #expect(dictMatrix.matrix == expected)

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        dictMatrix[2, 1] = "2:1"

        expected = [
            2: [1: "2:1"]
        ]

        Self.print_dictMatrix_forEach       (source: dictMatrix)
        Self.print_dictMatrix_forEach_bounds(source: dictMatrix)
        #expect(dictMatrix.bounds == Dictionary.Matrix.Bounds(minY: 2, maxY: 2, minX: 1, maxX: 1))
        #expect(dictMatrix.matrix == expected)

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        dictMatrix[2, 1] = "2:1"
        expected = [
            2: [1: "2:1"],
        ]

        Self.print_dictMatrix_forEach       (source: dictMatrix)
        Self.print_dictMatrix_forEach_bounds(source: dictMatrix)
        #expect(dictMatrix.bounds == Dictionary.Matrix.Bounds(minY: 2, maxY: 2, minX: 1, maxX: 1))
        #expect(dictMatrix.matrix == expected)

        dictMatrix[3, 2] = "3:2"
        expected = [
            2: [1: "2:1"],
            3: [2: "3:2"],
        ]

        Self.print_dictMatrix_forEach       (source: dictMatrix)
        Self.print_dictMatrix_forEach_bounds(source: dictMatrix)
        #expect(dictMatrix.bounds == Dictionary.Matrix.Bounds(minY: 2, maxY: 3, minX: 1, maxX: 2))
        #expect(dictMatrix.matrix == expected)

        dictMatrix[3, 2] = nil
        expected = [
            2: [1: "2:1"],
        ]

        Self.print_dictMatrix_forEach       (source: dictMatrix)
        Self.print_dictMatrix_forEach_bounds(source: dictMatrix)
        #expect(dictMatrix.bounds == Dictionary.Matrix.Bounds(minY: 2, maxY: 2, minX: 1, maxX: 1))
        #expect(dictMatrix.matrix == expected)

        dictMatrix[2, 1] = nil
        expected = [:]

        Self.print_dictMatrix_forEach       (source: dictMatrix)
        Self.print_dictMatrix_forEach_bounds(source: dictMatrix)
        #expect(dictMatrix.bounds == nil)
        #expect(dictMatrix.matrix == expected)
    }

    /* ######################### */
    /* ### MARK: random seed ### */
    /* ######################### */

    @Test func test_dictMatrix_randomSeed() async throws {
        let count = 0xfffff
        let dictMatrix = Dictionary<UInt, String>.Matrix()
        let time0 = Date()

        for _ in 0 ... count {
            let y = UInt.random(in: 0 ... 0xff)
            let x = UInt.random(in: 0 ... 0xff)
            let value = Bool.random() ? "\(UInt.random(in: 0 ... 0xff))" : nil
            dictMatrix[
                Matrix2dKey.Index(y),
                Matrix2dKey.Index(x)
            ] = value
        }

        let time1 = Date()
        print("Speed: \(count) iterations per \(time1.timeIntervalSince(time0)) seconds")
        #expect(true)
    }

}
