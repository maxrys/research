
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    init(hex: UInt, alpha: Double = 1) {
        self.init(.sRGB,
            red  : Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue : Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }

    var uint: UInt {
        let components = NSColor(self).cgColor.components
        let red   = UInt((components?[0] ?? 0) * 255)
        let green = UInt((components?[1] ?? 0) * 255)
        let blue  = UInt((components?[2] ?? 0) * 255)
        return (red << 16) | (green << 8) | blue
    }

}
