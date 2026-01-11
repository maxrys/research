
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Dictionary {

    final class Matrix {

        typealias Value = [
            Key: [Key: Element?]
        ]

        public private(set) var data: Value = [:]

        subscript(y: Key, x: Key) -> Element? {
            get {
                self.data[y]?[x] ?? nil
            }
            set {
                if (self.data[y] == nil) { self.data[y] = [:] }
                if (self.data[y] != nil) { self.data[y]![x] = newValue }
            }
        }

    }

}
