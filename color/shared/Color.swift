
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    init(fromUInt value: UInt, alpha: Double = 1) {
        self.init(.sRGB,
            red  : Double(value >> 16 & 0xff),
            green: Double(value >> 08 & 0xff),
            blue : Double(value >> 00 & 0xff),
            opacity: alpha
        )
    }

    var uint: UInt {
        let (rUInt, gUInt, bUInt) = self.RGB
        let R = Int(rUInt)
        let G = Int(gUInt)
        let B = Int(bUInt)
        return UInt((R << 16) | (G << 8) | B)
    }

    var RGB: (red: UInt8, green: UInt8, blue: UInt8) {
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return (0, 0, 0)
        }
        return (
            UInt8(components[0].rounded()).fixBounds(max: 255),
            UInt8(components[1].rounded()).fixBounds(max: 255),
            UInt8(components[2].rounded()).fixBounds(max: 255)
        )
     // let nsColor = NSColor(self)
     // return (
     //     UInt8(nsColor.redComponent  .rounded()).fixBounds(max: 255),
     //     UInt8(nsColor.greenComponent.rounded()).fixBounds(max: 255),
     //     UInt8(nsColor.blueComponent .rounded()).fixBounds(max: 255)
     // )

     // let nsColor = NSColor(self).usingColorSpace(.deviceRGB)!
     // return (
     //     UInt8(nsColor.redComponent  .rounded()).fixBounds(max: 255),
     //     UInt8(nsColor.greenComponent.rounded()).fixBounds(max: 255),
     //     UInt8(nsColor.blueComponent .rounded()).fixBounds(max: 255)
     // )

     // let resolve = self.resolve(in: EnvironmentValues())
     // return (
     //     UInt8(resolve.red  .rounded()).fixBounds(max: 255),
     //     UInt8(resolve.green.rounded()).fixBounds(max: 255),
     //     UInt8(resolve.blue .rounded()).fixBounds(max: 255)
     // )
    }

    var isDark: Bool {
        let (red, green, blue) = self.RGB
        let (_, _, brightness) = Self.RGBtoHSB(red, green, blue)
        return brightness >= 0.5
    }

    func isDarkFromRGB(red: UInt8, green: UInt8, blue: UInt8) -> Bool {
        let (_, _, brightness) = Self.RGBtoHSB(red, green, blue)
        return brightness >= 0.5
    }

    func brightnessSet(_ brightness: Double) -> Self {
        let (red, green, blue) = self.RGB
        let (hue, saturation, _) = Self.RGBtoHSB(red, green, blue)
        return Self(hue: hue / 360, saturation: saturation,
            brightness: brightness.fixBounds(max: 1.0)
        )
    }

    func brightnessShift(_ amount: Double) -> Self {
        let (red, green, blue) = self.RGB
        let (hue, saturation, brightness) = Self.RGBtoHSB(red, green, blue)
        return Self(hue: hue / 360, saturation: saturation,
            brightness: (brightness + amount).fixBounds(max: 1.0)
        )
    }

    func tune(hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, opacity: CGFloat = 1) -> Color {
        let nsColor = NSColor(self).usingColorSpace(.deviceRGB)!
        return Self(
            hue       : (nsColor.hueComponent        + hue       ).fixBounds(max: 1.0),
            saturation: (nsColor.saturationComponent + saturation).fixBounds(max: 1.0),
            brightness: (nsColor.brightnessComponent + brightness).fixBounds(max: 1.0),
            opacity   : (opacity)                                 .fixBounds(max: 1.0)
        )
    }

    static func RGBtoHSB(_ R: UInt8, _ G: UInt8, _ B: UInt8) -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {

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
