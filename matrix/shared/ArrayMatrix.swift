
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    final class Matrix {

        typealias Value = [
            [Element?]?
        ]

        public private(set) var data: Value = []

        subscript(x: Index, y: Index) -> Element? {
            get {
                self.data[safe: x]?[safe: y] ?? nil
            }
            set {
                if (self.data[safe: x] == nil) {
                    self.data[safe: x] = [] }
                self.data[safe: x]![safe: y] = newValue
            }
        }

    }

}
