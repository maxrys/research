
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    final class Matrix {

        typealias Value = [
            [Element?]?
        ]

        typealias Bounds = (
            minX: Index,
            maxX: Index,
            minY: Index,
            maxY: Index,
        )

        public private(set) var data: Value = []
        public let isTrimOn: Bool

        public var bounds: Bounds {
            var result: Bounds = (0, 0, 0, 0)
            for (x, rows) in self.data.enumerated() {
                result.maxX = Swift.max(result.maxX, x)
                if let rows {
                    for (y, col) in rows.enumerated() {
                        result.maxY = Swift.max(result.maxY, y)
                    }
                }
            }
            return result
        }

        init(isTrimOn: Bool = false) {
            self.isTrimOn = isTrimOn
        }

        subscript(y: Index, x: Index) -> Element? {
            get {
                self.data[safe: y]?[safe: x] ?? nil
            }
            set {
                if (self.data[safe: y] == nil) { self.data[safe: y] = [] }
                if (self.data[safe: y] != nil) { self.data[safe: y]?[safe: x] = newValue }
                if (self.isTrimOn) {
                    self.trimByX(y: y)
                    self.trimByY()
                }
            }
        }

        private func trimByX(y: Index) {
            while let row = self.data[safe: y], let lastValue = row.last, lastValue == nil {
                self.data[y]?.removeLast()
            }
        }

        private func trimByY() {
            while let rowLast = self.data.last, rowLast?.isEmpty == true {
                self.data.removeLast()
            }
        }

    }

}
