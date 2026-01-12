
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

        subscript(y: Index, x: Index) -> Element? {
            get {
                self.data[safe: y]?[safe: x] ?? nil
            }
            set {
                if (self.data[safe: y] == nil) { self.data[safe: y] = [] }
                if (self.data[safe: y] != nil) { self.data[safe: y]![safe: x] = newValue }
                if (self.isTrimOn) {
                    self.trimByX(y: y)
                    self.trimByY()
                }
            }
        }

        private func trimByX(y: Index) {
            if (self.data[safe: y] != nil) {
                while (self.data[safe: y]!.count > 0 &&
                       self.data[safe: y]![self.data[safe: y]!.count-1] == nil) {
                    self.data[safe: y]!.removeLast()
                }
            }
        }

        private func trimByY() {
            while (self.data.count > 0 &&
                   self.data[safe: self.data.count-1]?.count == 0) {
                self.data.removeLast()
            }
        }

    }

}
