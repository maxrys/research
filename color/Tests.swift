
import Testing
import SwiftUI

struct Tests {

    @Test func test_color_fromUInt_total() async throws {
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

    @Test func test_color_fromUInt() async throws {
        let color_R = Color(fromUInt: 0xFF_00_00) /* red */
        let color_G = Color(fromUInt: 0x00_FF_00) /* green */
        let color_B = Color(fromUInt: 0x00_00_FF) /* blue */

        #expect(color_R.uint == 0xFF_00_00)
        #expect(color_G.uint == 0x00_FF_00)
        #expect(color_B.uint == 0x00_00_FF)
    }

    @Test func test_color_toHSB_total() async throws {
        for uintValue in 0 ... 0xff_ff_ff + 1 {
            let (red, green, blue) = Color(fromUInt: UInt(uintValue)).RGBv1
            let (hue, saturation, brightness) = Color.toHSB(red, green, blue)
            #expect(hue        >= 0.0  );  if !(hue        >= 0.0  ) { return }
            #expect(hue        <= 360.0);  if !(hue        <= 360.0) { return }
            #expect(saturation >= 0.0  );  if !(saturation >= 0.0  ) { return }
            #expect(saturation <= 1.0  );  if !(saturation <= 1.0  ) { return }
            #expect(brightness >= 0.0  );  if !(brightness >= 0.0  ) { return }
            #expect(brightness <= 1.0  );  if !(brightness <= 1.0  ) { return }
        }
    }

    @Test func test_color_RGB() async throws {
        let color_R = Color(red: 255, green:   0, blue:   0) /* red */
        let color_G = Color(red:   0, green: 255, blue:   0) /* green */
        let color_B = Color(red:   0, green:   0, blue: 255) /* blue */

        #expect(color_R.RGBv1 == ( 255,   0,   0 ))
        #expect(color_G.RGBv1 == (   0, 255,   0 ))
        #expect(color_B.RGBv1 == (   0,   0, 255 ))

        #expect(color_R.RGBv2 == ( 255,   0,   0 ))
        #expect(color_G.RGBv2 == (   0, 255,   0 ))
        #expect(color_B.RGBv2 == (   0,   0, 255 ))
    }

    @Test func test_numeric_RGB() async throws {
        let rgbFFFFFF: UInt = 0xFFFFFF
        let rgbFFFF00: UInt = 0xFFFF00
        let rgbFF00FF: UInt = 0xFF00FF
        let rgbFF0000: UInt = 0xFF0000
        let rgb00FFFF: UInt = 0x00FFFF
        let rgb00FF00: UInt = 0x00FF00
        let rgb0000FF: UInt = 0x0000FF
        let rgb000000: UInt = 0x000000

        #expect(rgbFFFFFF.RGB == ( 255, 255, 255 ))
        #expect(rgbFFFF00.RGB == ( 255, 255,   0 ))
        #expect(rgbFF00FF.RGB == ( 255,   0, 255 ))
        #expect(rgbFF0000.RGB == ( 255,   0,   0 ))
        #expect(rgb00FFFF.RGB == (   0, 255, 255 ))
        #expect(rgb00FF00.RGB == (   0, 255,   0 ))
        #expect(rgb0000FF.RGB == (   0,   0, 255 ))
        #expect(rgb000000.RGB == (   0,   0,   0 ))
    }

    @Test func test_color_HSB() async throws {
        let rgbFFFFFF = Color(red: 255, green: 255, blue: 255).RGBv1
        let rgbFFFF00 = Color(red: 255, green: 255, blue:   0).RGBv1
        let rgbFF00FF = Color(red: 255, green:   0, blue: 255).RGBv1
        let rgbFF0000 = Color(red: 255, green:   0, blue:   0).RGBv1
        let rgb00FFFF = Color(red:   0, green: 255, blue: 255).RGBv1
        let rgb00FF00 = Color(red:   0, green: 255, blue:   0).RGBv1
        let rgb0000FF = Color(red:   0, green:   0, blue: 255).RGBv1
        let rgb000000 = Color(red:   0, green:   0, blue:   0).RGBv1

        #expect(Color.toHSB(rgbFFFFFF.red, rgbFFFFFF.green, rgbFFFFFF.blue) == (   0.0, 0.0, 1.0 ))
        #expect(Color.toHSB(rgbFFFF00.red, rgbFFFF00.green, rgbFFFF00.blue) == (  60.0, 1.0, 1.0 ))
        #expect(Color.toHSB(rgbFF00FF.red, rgbFF00FF.green, rgbFF00FF.blue) == ( 300.0, 1.0, 1.0 ))
        #expect(Color.toHSB(rgbFF0000.red, rgbFF0000.green, rgbFF0000.blue) == (   0.0, 1.0, 1.0 ))
        #expect(Color.toHSB(rgb00FFFF.red, rgb00FFFF.green, rgb00FFFF.blue) == ( 180.0, 1.0, 1.0 ))
        #expect(Color.toHSB(rgb00FF00.red, rgb00FF00.green, rgb00FF00.blue) == ( 120.0, 1.0, 1.0 ))
        #expect(Color.toHSB(rgb0000FF.red, rgb0000FF.green, rgb0000FF.blue) == ( 240.0, 1.0, 1.0 ))
        #expect(Color.toHSB(rgb000000.red, rgb000000.green, rgb000000.blue) == (   0.0, 0.0, 0.0 ))

        let rgb7F7F7F = Color(red: 127, green: 127, blue: 127).RGBv1
        let rgb7F7F00 = Color(red: 127, green: 127, blue:   0).RGBv1
        let rgb7F007F = Color(red: 127, green:   0, blue: 127).RGBv1
        let rgb7F0000 = Color(red: 127, green:   0, blue:   0).RGBv1
        let rgb007F7F = Color(red:   0, green: 127, blue: 127).RGBv1
        let rgb007F00 = Color(red:   0, green: 127, blue:   0).RGBv1
        let rgb00007F = Color(red:   0, green:   0, blue: 127).RGBv1

        #expect(Color.toHSB(rgb7F7F7F.red, rgb7F7F7F.green, rgb7F7F7F.blue) == (   0.0, 0.0, 0.4980392156862745 ))
        #expect(Color.toHSB(rgb7F7F00.red, rgb7F7F00.green, rgb7F7F00.blue) == (  60.0, 1.0, 0.4980392156862745 ))
        #expect(Color.toHSB(rgb7F007F.red, rgb7F007F.green, rgb7F007F.blue) == ( 300.0, 1.0, 0.4980392156862745 ))
        #expect(Color.toHSB(rgb7F0000.red, rgb7F0000.green, rgb7F0000.blue) == (   0.0, 1.0, 0.4980392156862745 ))
        #expect(Color.toHSB(rgb007F7F.red, rgb007F7F.green, rgb007F7F.blue) == ( 180.0, 1.0, 0.4980392156862745 ))
        #expect(Color.toHSB(rgb007F00.red, rgb007F00.green, rgb007F00.blue) == ( 120.0, 1.0, 0.4980392156862745 ))
        #expect(Color.toHSB(rgb00007F.red, rgb00007F.green, rgb00007F.blue) == ( 240.0, 1.0, 0.4980392156862745 ))
    }

}
