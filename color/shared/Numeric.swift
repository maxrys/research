
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

extension Numeric where Self == Decimal {

    var double: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }

}
