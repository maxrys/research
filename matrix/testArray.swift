
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

class TestArray {

    /* ####################### */
    /* ### MARK: arraySafe ### */
    /* ####################### */

    static func test_arraySafe() {
        var data    : [String?] = []
        var expected: [String?] = []

        data = []
        data[safe: 0] = nil
        expected = [nil]
        print(data == expected)

        data = []
        data[safe: 0] = "index:0"
        expected = ["index:0"]
        print(data == expected)

        data = []
        data[safe: 3] = "index:3"
        expected = [nil, nil, nil, "index:3"]
        print(data == expected)

        data = []
        data[safe: 3] = "index:3"
        data[safe: 1] = "index:1"
        data[safe: 5] = "index:5"
        expected = [nil, "index:1", nil, "index:3", nil, "index:5"]
        print(data == expected)

        data = []
        data[safe: 3] = "index:3"
        data[safe: 1] = "index:1"
        data[safe: 5] = "index:5"
        expected = [nil, "index:1", nil, "index:3", nil, "index:5"]
        print(data == expected)
        data[safe: 3] = nil
        expected = [nil, "index:1", nil, nil, nil, "index:5"]
        print(data == expected)
        data[safe: 5] = nil
        expected = [nil, "index:1", nil, nil, nil, nil]
        print(data == expected)
        data[safe: 1] = nil
        expected = [nil, nil, nil, nil, nil, nil]
        print(data == expected)
    }

    /* ##################### */
    /* ### MARK: forEach ### */
    /* ##################### */

    static func test_arrayMatrix_forEach(source: Array<String>.Matrix) {
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

    static func test_arrayMatrix_forEach_bounds(source: Array<String>.Matrix) {
        print("")
        let bounds = source.bounds
        for y in bounds.minY ... bounds.maxY { print("y = \(y) | ", terminator: "")
        for x in bounds.minX ... bounds.maxX {
            if let value = source[y, x] { print("\(value) | ", terminator: "") }
            else                        { print(     "nil | ", terminator: "") }
        }; print(""); }
        print("")
    }

    /* ######################### */
    /* ### MARK: arrayMatrix ### */
    /* ######################### */

    static func test_arrayMatrix() {
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

        Self.test_arrayMatrix_forEach       (source: arrayMatrix)
        Self.test_arrayMatrix_forEach_bounds(source: arrayMatrix)
        print(arrayMatrix.data == expected)
        print(arrayMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 2))

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix()
        arrayMatrix[0, 2] = "0:2"
        expected = [
            [nil, nil, "0:2"],
        ]
        Self.test_arrayMatrix_forEach       (source: arrayMatrix)
        Self.test_arrayMatrix_forEach_bounds(source: arrayMatrix)
        print(arrayMatrix.data == expected)
        print(arrayMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 0))

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix()
        arrayMatrix[2, 0] = "2:0"
        expected = [
              nil,
              nil,
            ["2:0"],
        ]
        Self.test_arrayMatrix_forEach       (source: arrayMatrix)
        Self.test_arrayMatrix_forEach_bounds(source: arrayMatrix)
        print(arrayMatrix.data == expected)
        print(arrayMatrix.bounds == (minX: 0, maxX: 0, minY: 0, maxY: 2))

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix()
        arrayMatrix[0, 2] = nil
        arrayMatrix[1, 2] = nil
        arrayMatrix[2, 1] = "2:1"
        arrayMatrix[1, 2] = nil
        arrayMatrix[2, 2] = nil
        arrayMatrix[3, 2] = nil

        expected = [
            [ nil ,  nil ,  nil ],
            [ nil,   nil ,  nil ],
            [ nil , "2:1",  nil ],
            [ nil,   nil ,  nil ],
        ]

        Self.test_arrayMatrix_forEach       (source: arrayMatrix)
        Self.test_arrayMatrix_forEach_bounds(source: arrayMatrix)
        print(arrayMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 3))
        print(arrayMatrix.data == expected)
    }

    static func test_arrayMatrix_isTrimOn() {
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

        Self.test_arrayMatrix_forEach       (source: arrayMatrix)
        Self.test_arrayMatrix_forEach_bounds(source: arrayMatrix)
        print(arrayMatrix.data == expected)
        print(arrayMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 2))

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix(isTrimOn: true)
        arrayMatrix[0, 2] = "0:2"
        expected = [
            [nil, nil, "0:2"],
        ]
        Self.test_arrayMatrix_forEach       (source: arrayMatrix)
        Self.test_arrayMatrix_forEach_bounds(source: arrayMatrix)
        print(arrayMatrix.data == expected)
        print(arrayMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 0))

        /* ################################################################################ */

        arrayMatrix = Array<String>.Matrix(isTrimOn: true)
        arrayMatrix[2, 0] = "2:0"
        expected = [
              nil,
              nil,
            ["2:0"],
        ]
        Self.test_arrayMatrix_forEach       (source: arrayMatrix)
        Self.test_arrayMatrix_forEach_bounds(source: arrayMatrix)
        print(arrayMatrix.data == expected)
        print(arrayMatrix.bounds == (minX: 0, maxX: 0, minY: 0, maxY: 2))

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
            [ nil , "2:1"],
        ]

        Self.test_arrayMatrix_forEach       (source: arrayMatrix)
        Self.test_arrayMatrix_forEach_bounds(source: arrayMatrix)
        print(arrayMatrix.bounds == (minX: 0, maxX: 1, minY: 0, maxY: 2))
        print(arrayMatrix.data == expected)
    }

    /* #################### */
    /* ### MARK: random ### */
    /* #################### */

    static func test_arrayMatrix_random() {
        let arrayMatrix = Array<Int>.Matrix()

        for _ in 0 ... 0xffff {
            let x = Int.random(in: 0 ... 0xff)
            let y = Int.random(in: 0 ... 0xff)
            let value = Bool.random() ? Int.random(in: 0 ... 0xff) : nil
            arrayMatrix[x, y] = value
        }

        print(true)
    }

    static func test_arrayMatrix_random_isTrimOn() {
        let arrayMatrix = Array<Int>.Matrix(isTrimOn: true)

        for _ in 0 ... 0xffff {
            let x = Int.random(in: 0 ... 0xff)
            let y = Int.random(in: 0 ... 0xff)
            let value = Bool.random() ? Int.random(in: 0 ... 0xff) : nil
            arrayMatrix[x, y] = value
        }

        print(true)
    }

}
