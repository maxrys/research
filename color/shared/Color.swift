
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

    var HSB: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return (0, 0, 0)
        }
        let R = components[0]
        let G = components[1]
        let B = components[2]
        let maxRGB = max(R, G, B)
        let minRGB = min(R, G, B)
        let delta = maxRGB - minRGB
        var hue: CGFloat = 0
        let saturation: CGFloat = delta / maxRGB
        let brightness = maxRGB

        if (maxRGB == 0) {
            return (0, 0, 0)
        }
        if (delta == 0) {
            return (0, saturation, brightness)
        }

        if      (R == maxRGB) { hue =     (G - B) / delta }
        else if (G == maxRGB) { hue = 2 + (B - R) / delta }
        else                  { hue = 4 + (R - G) / delta }
        hue *= 60 /* convert to degrees */
        if hue < 0 {
            hue += 360
        }

        return (hue, saturation, brightness)
    }

    func hueShift(amount: CGFloat) -> Self {
        let (H, S, B) = self.HSB
        return Self(
            hue       : H + amount,
            saturation: S,
            brightness: B,
            opacity   : 1.0
        )
    }

    func saturationShift(amount: CGFloat) -> Self {
        let (H, S, B) = self.HSB
        return Self(
            hue       : H,
            saturation: S + amount,
            brightness: B,
            opacity   : 1.0
        )
    }

    func brightnessShift(amount: CGFloat) -> Self {
        let (H, S, B) = self.HSB
        return Self(
            hue       : H,
            saturation: S,
            brightness: B + amount,
            opacity   : 1.0
        )
    }

}
