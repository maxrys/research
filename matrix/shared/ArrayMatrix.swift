
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    final class Matrix {

        typealias Value = [
            [Element?]?
        ]

        public private(set) var data: Value = []
        public let isTrimOn: Bool

        init(isTrimOn: Bool = false) {
            self.isTrimOn = isTrimOn
        }

        subscript(x: Index, y: Index) -> Element? {
            get {
                self.data[safe: x]?[safe: y] ?? nil
            }
            set {
                if (self.data[safe: x] == nil) { self.data[safe: x] = [] }
                if (self.data[safe: x] != nil) { self.data[safe: x]![safe: y] = newValue }
                if (self.isTrimOn) {
                    self.trim(x: x)
                }
            }
        }

        private func trim(x: Index) {
            if (self.data[safe: x] != nil) {
                while (self.data[safe: x]!.count > 0 && self.data[safe: x]![self.data[safe: x]!.count-1] == nil) {
                    self.data[safe: x]!.removeLast()
                }
                while (self.data.count > 0 && self.data[safe: self.data.count-1]?.count == 0) {
                    self.data.removeLast()
                }
            }
        }

    }

}
