
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Dictionary where Key: Comparable {

    @inlinable public var last: Element? {
        get {
            if let key = self.keys.max(by: { (lhs, rhs) in lhs < rhs } ) {
                if let value = self[key] {
                    return (key: key, value: value)
                }
            }
            return nil
        }
    }

    @inlinable public var lastKey: Key? {
        get {
            self.last?.key
        }
    }

    @inlinable public mutating func append(_ value: Value) where Key: Numeric {
        if let lastKey = self.lastKey { self[lastKey + 1] = value }
        else                          { self[          0] = value }
    }

}
