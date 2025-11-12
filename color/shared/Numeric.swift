
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

extension Numeric {

    func fixBounds(min: Self = 0, max: Self) -> Self where Self: Comparable {
        if (self < min) { return min }
        if (self > max) { return max }
        return self
    }

}

extension Numeric where Self == Decimal {

    var double: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }

}

extension Numeric where Self == UInt {

    var RGB: (red: UInt8, green: UInt8, blue: UInt8) {(
        UInt8(self >> 16 & 0xff),
        UInt8(self >> 08 & 0xff),
        UInt8(self >> 00 & 0xff),
    )}

}
