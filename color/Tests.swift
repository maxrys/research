
import Testing
import SwiftUI

struct Tests {

    func formatDouble(_ value: Double, fractionLength: Int = 3) -> String {
        value.formatted(
            .number.precision(
                .fractionLength(fractionLength)
            )
        )
    }

    @Test func test_color_fromUInt_total() async throws {
        for uintValue in 0 ... 0x_ff_ff_ff + 1 {
            let color = Color(fromUInt: UInt(uintValue))
            let received = color.uint
            let expected = uintValue & 0xff_ff_ff
            #expect(received == expected)
            if (received != expected) {
                return
            }
        }
    }

    @Test func test_color_HSB_total() async throws {
        for uintValue in 0 ... 0x_ff_ff_ff + 1 {
            let (H, S, B) = Color(fromUInt: UInt(uintValue)).HSB
            #expect(H >= 0.0)
            #expect(H <= 360.0)
            #expect(S >= 0.0)
            #expect(S <= 1.0)
            #expect(B >= 0.0)
            #expect(B <= 1.0)
        }
    }

    @Test func test_color_RGB() async throws {
        let color_R = Color(red: 255, green:   0, blue:   0) /* red */
        let color_G = Color(red:   0, green: 255, blue:   0) /* green */
        let color_B = Color(red:   0, green:   0, blue: 255) /* blue */

        #expect( color_R.RGB == ( 255.0,   0.0,   0.0 ) )
        #expect( color_G.RGB == (   0.0, 255.0,   0.0 ) )
        #expect( color_B.RGB == (   0.0,   0.0, 255.0 ) )

        #expect( color_R.HSB == (   0.0,   1.0,   1.0 ) )
        #expect( color_G.HSB == ( 120.0,   1.0,   1.0 ) )
        #expect( color_B.HSB == ( 240.0,   1.0,   1.0 ) )
    }

    @Test func test_color_HSB() async throws {
        let color_R = Color(hue:   0, saturation: 1.0, brightness: 1.0) /* red */
        let color_G = Color(hue: 120, saturation: 1.0, brightness: 1.0) /* green */
        let color_B = Color(hue: 240, saturation: 1.0, brightness: 1.0) /* blue */

        dump( color_R.RGB )
        dump( color_G.RGB )
        dump( color_B.RGB )

        dump( color_R.HSB )
        dump( color_G.HSB )
        dump( color_B.HSB )
    }

    @Test func test_color_hueShift() async throws {
        for i in 0 ... 360 + 1 {
            let color = Color(hue: 1, saturation: 0.5, brightness: 0.5)
            let newColorAmount = CGFloat(i)
            let newColor = color.hueShift(amount: newColorAmount)
            print(
                "i: \(i) | " +
                "H: \(self.formatDouble(newColor.HSB.hue)) | " +
                "S: \(self.formatDouble(newColor.HSB.saturation)) | " +
                "B: \(self.formatDouble(newColor.HSB.brightness))"
            )
        }
    }

    @Test func test_color_saturationShift() async throws {
        for i in 0 ... 100 + 1 {
            let color = Color(hue: 1, saturation: 0.01, brightness: 0.01)
            let newColorAmount = Decimal(i) * Decimal(0.01)
            let newColor = color.saturationShift(amount: newColorAmount.double)
            print(
                "i: \(i) | " +
                "H: \(self.formatDouble(newColor.HSB.hue)) | " +
                "S: \(self.formatDouble(newColor.HSB.saturation)) | " +
                "B: \(self.formatDouble(newColor.HSB.brightness))"
            )
        }
    }

    @Test func test_color_brightnessShift() async throws {
        for i in 0 ... 100 + 1 {
            let color = Color(hue: 1, saturation: 0.01, brightness: 0.01)
            let newColorAmount = Decimal(i) * Decimal(0.01)
            let newColor = color.brightnessShift(amount: newColorAmount.double)
            print(
                "i: \(i) | " +
                "H: \(self.formatDouble(newColor.HSB.hue)) | " +
                "S: \(self.formatDouble(newColor.HSB.saturation)) | " +
                "B: \(self.formatDouble(newColor.HSB.brightness))"
            )
        }
    }

}
