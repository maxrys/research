
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

    subscript(safe index: Index) -> Element? {
        get {
            indices.contains(index) ? self[index] : nil
        }
        set {
            guard let newValue else { return }
            if      (index <  self.count) { self[index] = newValue }
            else if (index == self.count) { self.append(newValue) }
            else if (index >  self.count) { /* do nothing */ }
        }
    }

}
