
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension UInt {

    func bitGet(position: UInt8) -> UInt8 {
        return UInt8(self >> position & 0b1)
    }

    mutating func bitSet(position: UInt8, isOn: Bool = false) {
        if (isOn) { self = self |  (0b1 << position) }
        else      { self = self & ~(0b1 << position) }
    }

    mutating func bitToggle(position: UInt8) {
        self = self ^ (0b1 << position)
    }

}
