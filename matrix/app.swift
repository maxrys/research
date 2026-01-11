
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
            arrayMatrix[rowNum, colNum] = "y=\(rowNum)|x=\(colNum)"
        }}

        let expected: [[String?]] = [
            ["y=0|x=0", "y=0|x=1", "y=0|x=2", "y=0|x=3", "y=0|x=4"],
            ["y=1|x=0", "y=1|x=1", "y=1|x=2", "y=1|x=3", "y=1|x=4"],
            ["y=2|x=0", "y=2|x=1", "y=2|x=2", "y=2|x=3", "y=2|x=4"],
            ["y=3|x=0", "y=3|x=1", "y=3|x=2", "y=3|x=3", "y=3|x=4"],
            ["y=4|x=0", "y=4|x=1", "y=4|x=2", "y=4|x=3", "y=4|x=4"],
        ]

        print(arrayMatrix.data == expected)
    }

    func test_arrayMatrix_withHoles() {
        let arrayMatrix = Array<String>.Matrix()

        arrayMatrix[0, 0] = "y=0|x=0"
        arrayMatrix[0, 2] = "y=0|x=2"
        arrayMatrix[0, 4] = "y=0|x=4"
        arrayMatrix[1, 1] = "y=1|x=1"
        arrayMatrix[1, 3] = "y=1|x=3"
        arrayMatrix[2, 0] = "y=2|x=0"
        arrayMatrix[2, 2] = "y=2|x=2"
        arrayMatrix[2, 3] = nil
        arrayMatrix[3, 1] = "y=3|x=1"
        arrayMatrix[3, 3] = "y=3|x=3"
        arrayMatrix[4, 0] = "y=4|x=0"
        arrayMatrix[4, 1] = nil
        arrayMatrix[5, 0] = nil

        let expected: [[String?]] = [
            ["y=0|x=0",    nil   , "y=0|x=2",    nil   , "y=0|x=4"],
            [   nil   , "y=1|x=1",    nil   , "y=1|x=3",          ],
            ["y=2|x=0",    nil   , "y=2|x=2",    nil              ],
            [   nil   , "y=3|x=1",    nil   , "y=3|x=3",          ],
            ["y=4|x=0",    nil                                    ],
            [   nil   ,                                           ]
        ]

        print(arrayMatrix.data == expected)
    }

    func test_arrayMatrix_withHoles_isTrimOn() {
        let arrayMatrix = Array<String>.Matrix(isTrimOn: true)

        arrayMatrix[0, 0] = "y=0|x=0"
        arrayMatrix[0, 2] = "y=0|x=2"
        arrayMatrix[0, 4] = "y=0|x=4"
        arrayMatrix[1, 1] = "y=1|x=1"
        arrayMatrix[1, 3] = "y=1|x=3"
        arrayMatrix[2, 0] = "y=2|x=0"
        arrayMatrix[2, 2] = "y=2|x=2"
        arrayMatrix[2, 3] = nil
        arrayMatrix[3, 1] = "y=3|x=1"
        arrayMatrix[3, 3] = "y=3|x=3"
        arrayMatrix[4, 0] = "y=4|x=0"
        arrayMatrix[4, 1] = nil
        arrayMatrix[5, 0] = nil

        let expected: [[String?]] = [
            ["y=0|x=0",    nil   , "y=0|x=2",    nil   , "y=0|x=4"],
            [   nil   , "y=1|x=1",    nil   , "y=1|x=3",          ],
            ["y=2|x=0",    nil   , "y=2|x=2",                     ],
            [   nil   , "y=3|x=1",    nil   , "y=3|x=3",          ],
            ["y=4|x=0",                                           ]
        ]

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
