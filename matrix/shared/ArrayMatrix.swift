
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
                self.data[safe: x]?[safe: y] ?? nil
            }
            set {
                if let _ = self.data[safe: x] {
                    self.data[safe: x]![safe: y] = newValue
                } else {
                    self.data[safe: x] = [
                        newValue
                    ]
                }
            }
        }

    }

}
