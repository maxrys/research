
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    final class Matrix {

        struct Bounds: Equatable {
            var minY: Index
            var maxY: Index
            var minX: Index
            var maxX: Index
        }

        public private(set) var data: [
            [Element?]?
        ] = []

        public let isTrimOn: Bool

        public var bounds: Bounds? {
            guard !self.data.isEmpty else { return nil }
            var result = Bounds(minY: 0, maxY: 0, minX: 0, maxX: 0)
            for (y, rows) in self.data.enumerated() {
                result.maxY = Swift.max(result.maxY, y)
                if let rows {
                    for (x, _) in rows.enumerated() {
                        result.maxX = Swift.max(result.maxX, x)
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
                    /* trim "nil" in row: ["a", "b", "c" ... nil, nil, nil] */
                    while let row = self.data[safe: y], let value = row.last, value == nil {
                        self.data[y]?.removeLast()
                    }
                    /* empty array to "nil" in row: [] -> nil */
                    if let row = self.data[safe: y], row is Array && row.isEmpty == true {
                        self.data[y] = nil
                    }
                    /* trim "nil" in data: [ ["a", "b", "c"], ["d", "e", "f"] ... nil, nil, nil ] */
                    while let row = self.data.last, row == nil || (row is Array && row?.isEmpty == true) {
                        self.data.removeLast()
                    }
                }
            }
        }

    }

}
