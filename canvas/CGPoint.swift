
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

extension CGPoint {

    static func + (lhs: Self, rhs: Self) -> Self {
        return Self(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y
        )
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        return Self(
            x: lhs.x - rhs.x,
            y: lhs.y - rhs.y
        )
    }

}
