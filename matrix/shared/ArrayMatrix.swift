
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    final class Matrix {

        typealias Value = [
            [Element?]
        ]

        public private(set) var data: Value = []

        subscript(x: Index, y: Index) -> Element? {
            get {
                self.data[x][y]
            }
            set {
                //if let _ = self.data[fill: x] {
                //    self.data[fill: x]![fill: y] = newValue
                //} else {
                //    self.data[fill: x] = [
                //        newValue
                //    ]
                //}
            }
        }

    }

}
