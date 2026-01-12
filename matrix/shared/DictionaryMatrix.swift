
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
            Key: [Key: Value?]?
        ] = [:]

        public var bounds: Bounds {
            var result: Bounds = (0, 0, 0, 0)
            for (y, rows) in self.data {
                result.maxY = Swift.max(result.maxY, y)
                if let rows {
                    for (x, _) in rows {
                        result.maxX = Swift.max(result.maxX, x)
                    }
                }
            }
            return result
        }

        subscript(y: Key, x: Key) -> Value? {
            get {
                self.data[y]??[x] ?? nil
            }
            set {
                if (self.data[y] == nil) { self.data[y] = [:] }
                if (self.data[y] != nil) { self.data[y]??[x] = newValue }
            }
        }

    }

}
