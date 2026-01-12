
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

class TestDictionary {

    /* ##################### */
    /* ### MARK: forEach ### */
    /* ##################### */

    static func test_dictMatrix_forEach(source: Dictionary<UInt, String>.Matrix) {
        print("")
        for (y, rows) in source.data {
            print("y = \(y) | ", terminator: "")
            if let rows {
                for (_, value) in rows {
                    if let value { print("\(value) | ", terminator: "") }
                    else         { print(     "nil | ", terminator: "") }
                }
            }
            print("")
        }
        print("")
    }

    static func test_dictMatrix_forEach_bounds(source: Dictionary<UInt, String>.Matrix) {
        print("")
        let bounds = source.bounds
        for y in bounds.minY ... bounds.maxY { print("y = \(y) | ", terminator: "")
        for x in bounds.minX ... bounds.maxX {
            if let value = source[y, x] { print("\(value) | ", terminator: "") }
            else                        { print(     "nil | ", terminator: "") }
        }; print(""); }
        print("")
    }

    /* ############################## */
    /* ### MARK: dictMatrix ### */
    /* ############################## */

    static func test_dictMatrix() {
        var dictMatrix: Dictionary<UInt, String>.Matrix
        var expected: [UInt: [UInt: String?]?]

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        for rowNum in 0 ..< 3 {
        for colNum in 0 ..< 3 {
            dictMatrix[UInt(rowNum), UInt(colNum)] = "\(rowNum):\(colNum)"
        }}

        expected = [
            0: [1: "0:0", 2: "0:1", 3: "0:2"],
            1: [1: "1:0", 2: "1:1", 3: "1:2"],
            2: [1: "2:0", 2: "2:1", 3: "2:2"],
        ]

        Self.test_dictMatrix_forEach       (source: dictMatrix)
        Self.test_dictMatrix_forEach_bounds(source: dictMatrix)
        print(dictMatrix.data == expected)
        print(dictMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 2))

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        dictMatrix[0, 2] = "0:2"
        expected = [
            0: [0: nil, 1: nil, 2: "0:2"],
        ]
        Self.test_dictMatrix_forEach       (source: dictMatrix)
        Self.test_dictMatrix_forEach_bounds(source: dictMatrix)
        print(dictMatrix.data == expected)
        print(dictMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 0))

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        dictMatrix[2, 0] = "2:0"
        expected = [
            0: nil,
            1: nil,
            2: [0: "2:0"],
        ]
        Self.test_dictMatrix_forEach       (source: dictMatrix)
        Self.test_dictMatrix_forEach_bounds(source: dictMatrix)
        print(dictMatrix.data == expected)
        print(dictMatrix.bounds == (minX: 0, maxX: 0, minY: 0, maxY: 2))

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        dictMatrix[0, 2] = nil
        dictMatrix[1, 2] = nil
        dictMatrix[2, 1] = "2:1"
        dictMatrix[1, 2] = nil
        dictMatrix[2, 2] = nil
        dictMatrix[3, 2] = nil

        expected = [
            0: [ 0: nil, 1:  nil , 2: nil ],
            1: [ 0: nil, 1:  nil , 2: nil ],
            2: [ 0: nil, 1: "2:1", 2: nil ],
            3: [ 0: nil, 1:  nil , 2: nil ],
        ]

        Self.test_dictMatrix_forEach       (source: dictMatrix)
        Self.test_dictMatrix_forEach_bounds(source: dictMatrix)
        print(dictMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 3))
        print(dictMatrix.data == expected)

        /* ################################################################################ */

        dictMatrix = Dictionary<UInt, String>.Matrix()
        dictMatrix[2, 1] = "2:1"
        expected = [
            0: nil,
            1: nil,
            2: [ 0: nil , 1: "2:1" ],
        ]

        Self.test_dictMatrix_forEach       (source: dictMatrix)
        Self.test_dictMatrix_forEach_bounds(source: dictMatrix)
        print(dictMatrix.bounds == (minX: 0, maxX: 1, minY: 0, maxY: 2))
        print(dictMatrix.data == expected)

        dictMatrix[3, 2] = "3:2"
        expected = [
            0: nil,
            1: nil,
            2: [ 0: nil, 1: "2:1"          ],
            3: [ 0: nil, 1:  nil, 2: "3:2" ],
        ]

        Self.test_dictMatrix_forEach       (source: dictMatrix)
        Self.test_dictMatrix_forEach_bounds(source: dictMatrix)
        print(dictMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 3))
        print(dictMatrix.data == expected)

        dictMatrix[3, 2] = nil
        expected = [
            0: nil,
            1: nil,
            2: [ 0: nil, 1: "2:1"        ],
            3: [ 0: nil, 1:  nil, 2: nil ],
        ]

        Self.test_dictMatrix_forEach       (source: dictMatrix)
        Self.test_dictMatrix_forEach_bounds(source: dictMatrix)
        print(dictMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 3))
        print(dictMatrix.data == expected)

        dictMatrix[2, 1] = nil
        expected = [
            0: nil,
            1: nil,
            2: [ 0: nil, 1: nil         ],
            3: [ 0: nil, 1: nil, 2: nil ],
        ]

        Self.test_dictMatrix_forEach       (source: dictMatrix)
        Self.test_dictMatrix_forEach_bounds(source: dictMatrix)
        print(dictMatrix.bounds == (minX: 0, maxX: 2, minY: 0, maxY: 3))
        print(dictMatrix.data == expected)
    }

    /* ######################### */
    /* ### MARK: random seed ### */
    /* ######################### */

    static func test_dictMatrix_randomSeed() {
        let dictMatrix = Dictionary<UInt, String>.Matrix()

        for _ in 0 ... 0xffff {
            let x = UInt.random(in: 0 ... 0xff)
            let y = UInt.random(in: 0 ... 0xff)
            let value = Bool.random() ? "\(UInt.random(in: 0 ... 0xff))" : nil
            dictMatrix[x, y] = value
        }

        print(true)
    }

}
