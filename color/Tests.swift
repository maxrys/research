
import Testing
import SwiftUI

struct Tests {

    @Test func test_color_fromUInt() async throws {
        for uintValue in 0 ... 0xff_ff_ff + 1 {
            let color = Color(fromUInt: UInt(uintValue))
            let received = color.uint
            let expected = uintValue & 0xff_ff_ff
            #expect(received == expected)
            if (received != expected) {
                return
            }
        }
    }

    @Test func test_color_HSB() async throws {
        for uintValue in 0 ... 0xff_ff_ff + 1 {
            let (H, S, B) = Color(fromUInt: UInt(uintValue)).HSB
            #expect(H >= 0.0)
            #expect(H <= 360.0)
            #expect(S >= 0.0)
            #expect(S <= 1.0)
            #expect(B >= 0.0)
            #expect(B <= 1.0)
        }
    }

    @Test func test_color_hueShift() async throws {
        for i in 0 ... 360 + 1 {
            let color = Color(hue: 1, saturation: 0.01, brightness: 0.01)
            let newColorAmount = CGFloat(i)
            let newColor = color.hueShift(amount: newColorAmount)
            print(newColor.HSB)
        }
    }

    @Test func test_color_saturationShift() async throws {
        for i in 0 ... 100 + 1 {
            let color = Color(hue: 1, saturation: 0.01, brightness: 0.01)
            let newColorAmount = Decimal(i) * Decimal(0.01)
            let newColor = color.saturationShift(amount: newColorAmount.double)
            print(newColor.HSB)
        }
    }

    @Test func test_color_brightnessShift() async throws {
        for i in 0 ... 100 + 1 {
            let color = Color(hue: 1, saturation: 0.01, brightness: 0.01)
            let newColorAmount = Decimal(i) * Decimal(0.01)
            let newColor = color.brightnessShift(amount: newColorAmount.double)
            print(newColor.HSB)
        }
    }

}
