
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
             // if let nested = self.data[safe: x] {
             // }
                return nil
            }
            set {
            }
        }

    }

}
