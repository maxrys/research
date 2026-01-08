
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
        self.test_arrayMatrix()
    }

    func test_arrayMatrix() {
        let colCount = 5
        let rowCount = 5
        let arrayMatrix = Array<String>.Matrix()

        for rowNum in 0 ..< rowCount {
        for colNum in 0 ..< colCount {
            arrayMatrix[rowNum, colNum] = "r=\(rowNum)|c=\(colNum)"
        }}

        let result = arrayMatrix.data == [
            ["r=0|c=0", "r=0|c=1", "r=0|c=2", "r=0|c=3", "r=0|c=4"],
            ["r=1|c=0", "r=1|c=1", "r=1|c=2", "r=1|c=3", "r=1|c=4"],
            ["r=2|c=0", "r=2|c=1", "r=2|c=2", "r=2|c=3", "r=2|c=4"],
            ["r=3|c=0", "r=3|c=1", "r=3|c=2", "r=3|c=3", "r=3|c=4"],
            ["r=4|c=0", "r=4|c=1", "r=4|c=2", "r=4|c=3", "r=4|c=4"],
        ]
        print(result)
    }

}
