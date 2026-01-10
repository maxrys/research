
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
    }

    func test_arraySafe() {
        var data    : [String?] = []
        var expected: [String?] = []

        data = []
        data[safe: 0] = "value 1"
        expected = ["value 1"]
        print(data == expected)

        data = []
        data[safe: 2] = "value 3"
        expected = [nil, nil, "value 3"]
        print(data == expected)

        data = []
        data[safe: 2] = "value 3"
        data[safe: 3] = "value 4"
        expected = [nil, nil, "value 3", "value 4"]
        print(data == expected)

        data = []
        data[safe: 2] = "value 3"
        data[safe: 5] = "value 6"
        expected = [nil, nil, "value 3", nil, nil, "value 6"]
        print(data == expected)

        data = []
        data[safe: 2] = "value 3"
        data[safe: 5] = "value 6"
        data[safe: 0] = "value 1"
        expected = ["value 1", nil, "value 3", nil, nil, "value 6"]
        print(data == expected)
    }

    func test_arrayMatrix() {
        let colCount = 5
        let rowCount = 5
        let arrayMatrix = Array<String>.Matrix()

        for rowNum in 0 ..< rowCount {
        for colNum in 0 ..< colCount {
            arrayMatrix[rowNum, colNum] = "r=\(rowNum)|c=\(colNum)"
        }}

        let expected: [[String?]] = [
            ["r=0|c=0", "r=0|c=1", "r=0|c=2", "r=0|c=3", "r=0|c=4"],
            ["r=1|c=0", "r=1|c=1", "r=1|c=2", "r=1|c=3", "r=1|c=4"],
            ["r=2|c=0", "r=2|c=1", "r=2|c=2", "r=2|c=3", "r=2|c=4"],
            ["r=3|c=0", "r=3|c=1", "r=3|c=2", "r=3|c=3", "r=3|c=4"],
            ["r=4|c=0", "r=4|c=1", "r=4|c=2", "r=4|c=3", "r=4|c=4"],
        ]

        print(arrayMatrix.data == expected)
    }

    func test_arrayMatrix_withHoles() {
        let arrayMatrix = Array<String>.Matrix()

        arrayMatrix[0, 0] = "r=0|c=0"
        arrayMatrix[0, 2] = "r=0|c=2"
        arrayMatrix[0, 4] = "r=0|c=4"
        arrayMatrix[1, 1] = "r=1|c=1"
        arrayMatrix[1, 3] = "r=1|c=3"
        arrayMatrix[2, 0] = "r=2|c=0"
        arrayMatrix[2, 2] = "r=2|c=2"
        arrayMatrix[3, 1] = "r=3|c=1"
        arrayMatrix[3, 3] = "r=3|c=3"
        arrayMatrix[4, 0] = "r=4|c=0"

        let expected: [[String?]] = [
            ["r=0|c=0",    nil   , "r=0|c=2",    nil   , "r=0|c=4"],
            [   nil   , "r=1|c=1",    nil   , "r=1|c=3",          ],
            ["r=2|c=0",    nil   , "r=2|c=2",    nil   ,          ],
            [   nil   , "r=3|c=1",    nil   , "r=3|c=3",          ],
            ["r=4|c=0",                                           ],
        ]

        print(arrayMatrix.data == expected)
    }

}
