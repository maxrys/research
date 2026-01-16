
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Testing

struct TestArray {

    /* ############################ */
    /* ### MARK: arraySafeIndex ### */
    /* ############################ */

    @Test func test_arraySafeIndex() async throws {
        var data    : [String?] = []
        var expected: [String?] = []

        data = []
        data[safe: 0] = nil
        expected = [nil]
        #expect(data == expected)

        data = []
        data[safe: 0] = "index:0"
        expected = ["index:0"]
        #expect(data == expected)

        data = []
        data[safe: 3] = "index:3"
        expected = [nil, nil, nil, "index:3"]
        #expect(data == expected)

        data = []
        data[safe: 3] = "index:3"
        data[safe: 1] = "index:1"
        data[safe: 5] = "index:5"
        expected = [nil, "index:1", nil, "index:3", nil, "index:5"]
        #expect(data == expected)

        data = []
        data[safe: 3] = "index:3"
        data[safe: 1] = "index:1"
        data[safe: 5] = "index:5"
        expected = [nil, "index:1", nil, "index:3", nil, "index:5"]
        #expect(data == expected)
        data[safe: 3] = nil
        expected = [nil, "index:1", nil, nil, nil, "index:5"]
        #expect(data == expected)
        data[safe: 5] = nil
        expected = [nil, "index:1", nil, nil, nil, nil]
        #expect(data == expected)
        data[safe: 1] = nil
        expected = [nil, nil, nil, nil, nil, nil]
        #expect(data == expected)
    }

    /* ##################### */
    /* ### MARK: forEach ### */
    /* ##################### */

    static func print_arrayMatrix_forEach(source: Array<String>.Matrix) {
        print("")
        for (y, rows) in source.data.enumerated() {
            print("y = \(y) | ", terminator: "")
            if let rows {
                for (_, value) in rows.enumerated() {
                    if let value { print("\(value) | ", terminator: "") }
                    else         { print(     "nil | ", terminator: "") }
                }
            }
            print("")
        }
        print("")
    }

    static func print_arrayMatrix_forEach_bounds(source: Array<String>.Matrix) {
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

    /* ######################### */
    /* ### MARK: arrayMatrix ### */
    /* ######################### */

    @Test func test_arrayMatrix() async throws {
        var arrayMatrix: Array<String>.Matrix
        var expected: [[String?]?]

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix()
        for rowNum in 0 ..< 3 {
        for colNum in 0 ..< 3 {
            arrayMatrix[rowNum, colNum] = "\(rowNum):\(colNum)"
        }}

        expected = [
            ["0:0", "0:1", "0:2"],
            ["1:0", "1:1", "1:2"],
            ["2:0", "2:1", "2:2"],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 2, minX: 0, maxX: 2))
        #expect(arrayMatrix.data == expected)

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix()
        arrayMatrix[0, 2] = "0:2"
        expected = [
            [nil, nil, "0:2"],
        ]
        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 0, minX: 0, maxX: 2))
        #expect(arrayMatrix.data == expected)

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix()
        arrayMatrix[2, 0] = "2:0"
        expected = [
              nil,
              nil,
            ["2:0"],
        ]
        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 2, minX: 0, maxX: 0))
        #expect(arrayMatrix.data == expected)

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix()
        arrayMatrix[0, 2] = nil
        arrayMatrix[1, 2] = nil
        arrayMatrix[2, 1] = "2:1"
        arrayMatrix[1, 2] = nil
        arrayMatrix[2, 2] = nil
        arrayMatrix[3, 2] = nil

        expected = [
            [ nil,  nil ,  nil ],
            [ nil,  nil ,  nil ],
            [ nil, "2:1",  nil ],
            [ nil,  nil ,  nil ],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 3, minX: 0, maxX: 2))
        #expect(arrayMatrix.data == expected)

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix()
        arrayMatrix[2, 1] = "2:1"
        expected = [
              nil,
              nil,
            [ nil, "2:1" ],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 2, minX: 0, maxX: 1))
        #expect(arrayMatrix.data == expected)

        arrayMatrix[3, 2] = "3:2"
        expected = [
              nil,
              nil,
            [ nil, "2:1"        ],
            [ nil,  nil , "3:2" ],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 3, minX: 0, maxX: 2))
        #expect(arrayMatrix.data == expected)

        arrayMatrix[3, 2] = nil
        expected = [
              nil,
              nil,
            [ nil, "2:1"      ],
            [ nil,  nil , nil ],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 3, minX: 0, maxX: 2))
        #expect(arrayMatrix.data == expected)

        arrayMatrix[2, 1] = nil
        expected = [
              nil,
              nil,
            [ nil, nil      ],
            [ nil, nil, nil ],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 3, minX: 0, maxX: 2))
        #expect(arrayMatrix.data == expected)
    }

    @Test func test_arrayMatrix_isTrimOn() async throws {

        var arrayMatrix: Array<String>.Matrix
        var expected: [[String?]?]

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix(isTrimOn: true)
        for rowNum in 0 ..< 3 {
        for colNum in 0 ..< 3 {
            arrayMatrix[rowNum, colNum] = "\(rowNum):\(colNum)"
        }}

        expected = [
            ["0:0", "0:1", "0:2"],
            ["1:0", "1:1", "1:2"],
            ["2:0", "2:1", "2:2"],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 2, minX: 0, maxX: 2))
        #expect(arrayMatrix.data == expected)

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix(isTrimOn: true)
        arrayMatrix[0, 2] = "0:2"
        expected = [
            [nil, nil, "0:2"],
        ]
        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 0, minX: 0, maxX: 2))
        #expect(arrayMatrix.data == expected)

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix(isTrimOn: true)
        arrayMatrix[2, 0] = "2:0"
        expected = [
              nil,
              nil,
            ["2:0"],
        ]
        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 2, minX: 0, maxX: 0))
        #expect(arrayMatrix.data == expected)

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix(isTrimOn: true)
        arrayMatrix[0, 2] = nil
        arrayMatrix[1, 2] = nil
        arrayMatrix[2, 1] = "2:1"
        arrayMatrix[1, 2] = nil
        arrayMatrix[2, 2] = nil
        arrayMatrix[3, 2] = nil

        expected = [
              nil,
              nil,
            [ nil, "2:1"],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 2, minX: 0, maxX: 1))
        #expect(arrayMatrix.data == expected)

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix(isTrimOn: true)
        arrayMatrix[2, 1] = "2:1"
        expected = [
              nil,
              nil,
            [ nil, "2:1" ],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 2, minX: 0, maxX: 1))
        #expect(arrayMatrix.data == expected)

        arrayMatrix[3, 2] = "3:2"
        expected = [
              nil,
              nil,
            [ nil, "2:1"        ],
            [ nil,  nil , "3:2" ],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 3, minX: 0, maxX: 2))
        #expect(arrayMatrix.data == expected)

        arrayMatrix[3, 2] = nil
        expected = [
              nil,
              nil,
            [ nil, "2:1" ],
        ]

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == Array.Matrix.Bounds(minY: 0, maxY: 2, minX: 0, maxX: 1))
        #expect(arrayMatrix.data == expected)

        arrayMatrix[2, 1] = nil
        expected = []

        Self.print_arrayMatrix_forEach       (source: arrayMatrix)
        Self.print_arrayMatrix_forEach_bounds(source: arrayMatrix)
        #expect(arrayMatrix.bounds == nil)
        #expect(arrayMatrix.data == expected)
    }

    /* ######################### */
    /* ### MARK: random seed ### */
    /* ######################### */

    @Test func test_arrayMatrix_randomSeed() async throws {
        let arrayMatrix = Array<Int>.Matrix()

        for _ in 0 ... 0xffff {
            let y = Int.random(in: 0 ... 0xff)
            let x = Int.random(in: 0 ... 0xff)
            let value = Bool.random() ? Int.random(in: 0 ... 0xff) : nil
            arrayMatrix[y, x] = value
        }

        #expect(true)
    }

    @Test func test_arrayMatrix_randomSeed_isTrimOn() async throws {
        let arrayMatrix = Array<Int>.Matrix(isTrimOn: true)

        for _ in 0 ... 0xffff {
            let y = Int.random(in: 0 ... 0xff)
            let x = Int.random(in: 0 ... 0xff)
            let value = Bool.random() ? Int.random(in: 0 ... 0xff) : nil
            arrayMatrix[y, x] = value
        }

        #expect(true)
    }

}
