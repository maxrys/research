
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    @inlinable public var tuples: [(key: Index, value: Element)] {
        get {
            var result: [(key: Index, value: Element)] = []
            for i in 0 ..< self.count {
                result.insert(
                    (key: i, value: self[i]), at: i
                )
            }
            return result
        }
    }

    @inlinable public var last: Element? {
        get {
            return self.isEmpty ? nil : self[self.count-1]
        }
        set {
            if (self.isEmpty == false) {
                if let newValue = newValue {
                    self[self.count-1] = newValue
                }
            }
        }
    }

    subscript<T>(safe index: Index) -> T? where Element == T? {
        get {
            if (indices.contains(index))
                 { return self[index] }
            else { return nil }
        }
        set {
            if      (index <  self.count) { self[index] = newValue }
            else if (index == self.count) { self.append(newValue) }
            else if (index >  self.count) {
                for i in self.count ... index {
                    if (i != index) { self.append(nil) }
                    if (i == index) { self.append(newValue) }
                }
            }
        }
    }

}
