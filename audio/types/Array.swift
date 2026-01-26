
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    public typealias KeyValuePair = (
        key  : Int,
        value: Element
    )

    @inlinable public var tuples: [KeyValuePair] {
        get {
            var result: [KeyValuePair] = []
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

}
