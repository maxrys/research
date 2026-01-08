
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Dictionary {

    final class Matrix {

        typealias Value = [
            Key: [
                Key: Element?
            ]
        ]

        public private(set) var data: Value = [:]

        subscript(x: Key, y: Key) -> Element? {
            get {
                self.data[x]?[y] ?? nil
            }
            set {
                if let _ = self.data[x] {
                    self.data[x]![y] = newValue
                } else {
                    self.data[x] = [
                        y: newValue
                    ]
                }
            }
        }

    }

}
