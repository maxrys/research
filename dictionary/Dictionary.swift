
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

    @inlinable public var lastValue: Value? {
        get {
            self.last?.value
        }
        set {
            if let key = self.last?.key {
                self[key] = newValue
            }
        }
    }

    @inlinable public func previous(before: Key) -> Element? {
        var found: Key?
        for (key, _) in self {
            if (found == nil && key < before                ) { found = key }
            if (found != nil && key < before && key > found!) { found = key }
        }
        if (found != nil) {
            return (key: found!, value: self[found!]!)
        }
        return nil
    }

    @inlinable public func next(after: Key) -> Element? {
        var found: Key?
        for (key, _) in self {
            if (found == nil && key > after                ) { found = key }
            if (found != nil && key > after && key < found!) { found = key }
        }
        if (found != nil) {
            return (key: found!, value: self[found!]!)
        }
        return nil
    }

    @inlinable public func previousSlow(before: Key) -> Element? {
        return self.filter({ (key, value) in before > key }).ordered().last
    }

    @inlinable public func nextSlow(after: Key) -> Element? {
        return self.filter({ (key, value) in key > after }).ordered().first
    }

    @inlinable public func ordered() -> [Element] {
        self.sorted(by: { (lhs, rhs) in
            lhs.key < rhs.key
        })
    }

    @inlinable public mutating func append(_ value: Value) where Key: Numeric {
        if let lastKey = self.lastKey { self[lastKey + 1] = value }
        else                          { self[          0] = value }
    }

    @inlinable public mutating func appendAndReturnKey(_ value: Value) -> Key where Key: Numeric {
        if let lastKey = self.lastKey { self[lastKey + 1] = value; return lastKey + 1 }
        else                          { self[          0] = value; return           0 }
    }

}
