
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {
        }
    }

    init() {
        self.test_arraySafe()
        self.test_arrayMatrix()
        self.test_arrayMatrix_withHoles()
        self.test_arrayMatrix_withHoles_isTrimOn()
        self.test_arrayMatrix_random()
        self.test_arrayMatrix_random_isTrimOn()
    }

    func test_arraySafe() {
        var data    : [String?] = []
        var expected: [String?] = []

        data = []
        data[safe: 0] = nil
        expected = [nil]
        print(data == expected)

        data = []
        data[safe: 0] = "value 1"
        expected = ["value 1"]
        print(data == expected)

        data = []
        data[safe: 4] = "value 5"
        expected = [nil, nil, nil, nil, "value 5"]
        print(data == expected)

        data = []
        data[safe: 4] = "value 5"
        data[safe: 1] = "value 2"
        data[safe: 6] = "value 7"
        expected = [nil, "value 2", nil, nil, "value 5", nil, "value 7"]
        print(data == expected)

        data = []
        data[safe: 4] = "value 5"
        data[safe: 1] = "value 2"
        data[safe: 6] = "value 7"
        data[safe: 4] = nil
        data[safe: 6] = nil
        expected = [nil, "value 2", nil, nil, nil, nil, nil]
        print(data == expected)
    }

    func test_arrayMatrix() {
        let colCount = 5
        let rowCount = 5
        let arrayMatrix = Array<String>.Matrix()

        for rowNum in 0 ..< rowCount {
        for colNum in 0 ..< colCount {
            arrayMatrix[rowNum, colNum] = "\(rowNum):\(colNum)"
        }}

        let expected: [[String?]] = [
            ["0:0", "0:1", "0:2", "0:3", "0:4"],
            ["1:0", "1:1", "1:2", "1:3", "1:4"],
            ["2:0", "2:1", "2:2", "2:3", "2:4"],
            ["3:0", "3:1", "3:2", "3:3", "3:4"],
            ["4:0", "4:1", "4:2", "4:3", "4:4"],
        ]

        print(arrayMatrix.data == expected)
    }

    func test_arrayMatrix_withHoles() {
        let arrayMatrix = Array<String>.Matrix()

        arrayMatrix[0, 0] = "0:0"
        arrayMatrix[0, 2] = "0:2"
        arrayMatrix[0, 4] = "0:4"
        arrayMatrix[1, 1] = "1:1"
        arrayMatrix[1, 3] = "1:3"
        arrayMatrix[2, 0] = "2:0"
        arrayMatrix[2, 2] = "2:2"
        arrayMatrix[2, 3] = nil
        arrayMatrix[3, 1] = "3:1"
        arrayMatrix[3, 3] = "3:3"
        arrayMatrix[4, 0] = "4:0"
        arrayMatrix[4, 1] = nil
        arrayMatrix[5, 0] = nil

        let expected: [[String?]] = [
            ["0:0",  nil , "0:2",  nil, "0:4"],
            [ nil , "1:1",  nil , "1:3"      ],
            ["2:0",  nil , "2:2",  nil       ],
            [ nil , "3:1",  nil , "3:3"      ],
            ["4:0",  nil                     ],
            [ nil                            ]
        ]

        for (x, rows) in arrayMatrix.data.enumerated() {
            print("x = \(x) | ", terminator: "")
            if let rows {
                for (_, col) in rows.enumerated() {
                    if let col { print("\(col) | ", terminator: "") }
                    else       { print(   "nil | ", terminator: "") }
                }
            }
            print("")
        }

        print(arrayMatrix.data == expected)
    }

    func test_arrayMatrix_withHoles_isTrimOn() {
        let arrayMatrix = Array<String>.Matrix(isTrimOn: true)

        arrayMatrix[0, 0] = "0:0"
        arrayMatrix[0, 2] = "0:2"
        arrayMatrix[0, 4] = "0:4"
        arrayMatrix[1, 1] = "1:1"
        arrayMatrix[1, 3] = "1:3"
        arrayMatrix[2, 0] = "2:0"
        arrayMatrix[2, 2] = "2:2"
        arrayMatrix[2, 3] = nil
        arrayMatrix[3, 1] = "3:1"
        arrayMatrix[3, 3] = "3:3"
        arrayMatrix[4, 0] = "4:0"
        arrayMatrix[4, 1] = nil
        arrayMatrix[5, 0] = nil

        let expected: [[String?]] = [
            ["0:0",  nil , "0:2",  nil , "0:4"],
            [ nil , "1:1",  nil , "1:3"       ],
            ["2:0",  nil , "2:2"              ],
            [ nil , "3:1",  nil , "3:3"       ],
            ["4:0"                            ]
        ]

        for (x, rows) in arrayMatrix.data.enumerated() {
            print("x = \(x) | ", terminator: "")
            if let rows {
                for (_, col) in rows.enumerated() {
                    if let col { print("\(col) | ", terminator: "") }
                    else       { print(   "nil | ", terminator: "") }
                }
            }
            print("")
        }

        print(arrayMatrix.data == expected)
    }

    func test_arrayMatrix_random() {
        let arrayMatrix = Array<Int>.Matrix()

        for _ in 0 ... 0xffff {
            let x = Int.random(in: 0 ... 0xff)
            let y = Int.random(in: 0 ... 0xff)
            let value = Bool.random() ? Int.random(in: 0 ... 0xff) : nil
            arrayMatrix[x, y] = value
        }
    }

    func test_arrayMatrix_random_isTrimOn() {
        let arrayMatrix = Array<Int>.Matrix(isTrimOn: true)

        for _ in 0 ... 0xffff {
            let x = Int.random(in: 0 ... 0xff)
            let y = Int.random(in: 0 ... 0xff)
            let value = Bool.random() ? Int.random(in: 0 ... 0xff) : nil
            arrayMatrix[x, y] = value
        }
    }

}
