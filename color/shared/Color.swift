
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    init(fromUInt: UInt, alpha: Double = 1) {
        self.init(.sRGB,
            red  : Double((fromUInt >> 16) & 0xff) / 255.0,
            green: Double((fromUInt >> 08) & 0xff) / 255.0,
            blue : Double((fromUInt >> 00) & 0xff) / 255.0,
            opacity: alpha
        )
    }

    var uint: UInt {
        guard let components = self.cgColor?.components, components.count >= 3 else { return 0 }
        let R = UInt((components[0] * 255.0).rounded())
        let G = UInt((components[1] * 255.0).rounded())
        let B = UInt((components[2] * 255.0).rounded())
        return (R << 16) | (G << 8) | B
    }

    var RGBv1: (red: UInt8, green: UInt8, blue: UInt8) {
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return (0, 0, 0)
        }
        return (
            UInt8(components[0]).fixBounds(max: 255),
            UInt8(components[1]).fixBounds(max: 255),
            UInt8(components[2]).fixBounds(max: 255)
        )
    }

    var RGBv2: (red: UInt8, green: UInt8, blue: UInt8) {
        let nsColor = NSColor(self)
        var R: CGFloat = 0
        var G: CGFloat = 0
        var B: CGFloat = 0
        nsColor.getRed(&R, green: &G, blue: &B, alpha: nil)
        return (
            UInt8(R).fixBounds(max: 255),
            UInt8(G).fixBounds(max: 255),
            UInt8(B).fixBounds(max: 255)
        )
    }

    static func toHSB(red R: UInt8, green G: UInt8, blue B: UInt8) -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        let R = CGFloat(R)
        let G = CGFloat(G)
        let B = CGFloat(B)
        let minRGB = min(R, G, B)
        let maxRGB = max(R, G, B)
        let delta = maxRGB - minRGB
        var hue: CGFloat = 0
        let saturation: CGFloat = delta / maxRGB
        let brightness = maxRGB / 255

        if (maxRGB == 0) {
            return (0, 0, 0)
        }
        if (delta == 0) {
            return (0, saturation, brightness)
        }

        if (maxRGB == minRGB) { hue = 0 }
        else if (maxRGB == R) { hue = (60 * (G - B) / delta + 360).truncatingRemainder(dividingBy: 360) }
        else if (maxRGB == G) { hue = (60 * (B - R) / delta + 120).truncatingRemainder(dividingBy: 360) }
        else if (maxRGB == B) { hue = (60 * (R - G) / delta + 240).truncatingRemainder(dividingBy: 360) }

        return (hue, saturation, brightness)
    }

}
