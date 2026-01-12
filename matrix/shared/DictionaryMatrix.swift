
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Dictionary {

    final class Matrix where Key: UnsignedInteger & Comparable {

        typealias Bounds = (
            minX: Key,
            maxX: Key,
            minY: Key,
            maxY: Key,
        )

        public private(set) var data: [
            Key: [Key: Value]
        ] = [:]

        public var bounds: Bounds {
            let anyMinX = self.data.first?.value.first?.key ?? 0
            let anyMinY = self.data.keys.first              ?? 0
            var result: Bounds = (anyMinX, 0, anyMinY, 0)
            for (y, rows) in self.data {
                result.minY = Swift.min(result.minY, y)
                result.maxY = Swift.max(result.maxY, y)
                for (x, _) in rows {
                    result.minX = Swift.min(result.minX, x)
                    result.maxX = Swift.max(result.maxX, x)
                }
            }
            return result
        }

        subscript(y: Key, x: Key) -> Value? {
            get {
                self.data[y]?[x]
            }
            set {
                if (self.data[y] == nil) { self.data[y] = [:] }
                if (self.data[y] != nil) { self.data[y]?[x] = newValue }
                if let row = self.data[y], row.isEmpty {
                    self.data[y] = nil
                }
            }
        }

    }

}
