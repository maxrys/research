
import Testing
import SwiftUI

struct Tests {

    /* fromUInt */

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

    /* RGB */

    @Test func test_numeric_RGB() async throws {
        let uintFFFFFF: UInt = 0xFFFFFF
        let uintFFFF00: UInt = 0xFFFF00
        let uintFF00FF: UInt = 0xFF00FF
        let uintFF0000: UInt = 0xFF0000
        let uint00FFFF: UInt = 0x00FFFF
        let uint00FF00: UInt = 0x00FF00
        let uint0000FF: UInt = 0x0000FF
        let uint000000: UInt = 0x000000

        #expect(uintFFFFFF.RGB == ( 255, 255, 255 ))
        #expect(uintFFFF00.RGB == ( 255, 255,   0 ))
        #expect(uintFF00FF.RGB == ( 255,   0, 255 ))
        #expect(uintFF0000.RGB == ( 255,   0,   0 ))
        #expect(uint00FFFF.RGB == (   0, 255, 255 ))
        #expect(uint00FF00.RGB == (   0, 255,   0 ))
        #expect(uint0000FF.RGB == (   0,   0, 255 ))
        #expect(uint000000.RGB == (   0,   0,   0 ))
    }

    @Test func test_color_RGB() async throws {
        let color_R = Color(.sRGB, red: 255, green:   0, blue:   0, opacity: 1.0) /* red */
        let color_G = Color(.sRGB, red:   0, green: 255, blue:   0, opacity: 1.0) /* green */
        let color_B = Color(.sRGB, red:   0, green:   0, blue: 255, opacity: 1.0) /* blue */

        #expect(color_R.RGB == ( 255,   0,   0 ))
        #expect(color_G.RGB == (   0, 255,   0 ))
        #expect(color_B.RGB == (   0,   0, 255 ))
    }

    /* HSB */

    @Test func test_color_RGBtoHSB() async throws {
        let rgbFFFFFF = UInt(0xFFFFFF).RGB
        let rgbFFFF00 = UInt(0xFFFF00).RGB
        let rgbFF00FF = UInt(0xFF00FF).RGB
        let rgbFF0000 = UInt(0xFF0000).RGB
        let rgb00FFFF = UInt(0x00FFFF).RGB
        let rgb00FF00 = UInt(0x00FF00).RGB
        let rgb0000FF = UInt(0x0000FF).RGB
        let rgb000000 = UInt(0x000000).RGB

        #expect(Color.RGBtoHSB(rgbFFFFFF.red, rgbFFFFFF.green, rgbFFFFFF.blue) == (   0.0, 0.0, 1.0 ))
        #expect(Color.RGBtoHSB(rgbFFFF00.red, rgbFFFF00.green, rgbFFFF00.blue) == (  60.0, 1.0, 1.0 ))
        #expect(Color.RGBtoHSB(rgbFF00FF.red, rgbFF00FF.green, rgbFF00FF.blue) == ( 300.0, 1.0, 1.0 ))
        #expect(Color.RGBtoHSB(rgbFF0000.red, rgbFF0000.green, rgbFF0000.blue) == (   0.0, 1.0, 1.0 ))
        #expect(Color.RGBtoHSB(rgb00FFFF.red, rgb00FFFF.green, rgb00FFFF.blue) == ( 180.0, 1.0, 1.0 ))
        #expect(Color.RGBtoHSB(rgb00FF00.red, rgb00FF00.green, rgb00FF00.blue) == ( 120.0, 1.0, 1.0 ))
        #expect(Color.RGBtoHSB(rgb0000FF.red, rgb0000FF.green, rgb0000FF.blue) == ( 240.0, 1.0, 1.0 ))
        #expect(Color.RGBtoHSB(rgb000000.red, rgb000000.green, rgb000000.blue) == (   0.0, 0.0, 0.0 ))

        let rgb7F7F7F = UInt(0x7F7F7F).RGB
        let rgb7F7F00 = UInt(0x7F7F00).RGB
        let rgb7F007F = UInt(0x7F007F).RGB
        let rgb7F0000 = UInt(0x7F0000).RGB
        let rgb007F7F = UInt(0x007F7F).RGB
        let rgb007F00 = UInt(0x007F00).RGB
        let rgb00007F = UInt(0x00007F).RGB

        #expect(Color.RGBtoHSB(rgb7F7F7F.red, rgb7F7F7F.green, rgb7F7F7F.blue) == (   0.0, 0.0, 0.4980392156862745 ))
        #expect(Color.RGBtoHSB(rgb7F7F00.red, rgb7F7F00.green, rgb7F7F00.blue) == (  60.0, 1.0, 0.4980392156862745 ))
        #expect(Color.RGBtoHSB(rgb7F007F.red, rgb7F007F.green, rgb7F007F.blue) == ( 300.0, 1.0, 0.4980392156862745 ))
        #expect(Color.RGBtoHSB(rgb7F0000.red, rgb7F0000.green, rgb7F0000.blue) == (   0.0, 1.0, 0.4980392156862745 ))
        #expect(Color.RGBtoHSB(rgb007F7F.red, rgb007F7F.green, rgb007F7F.blue) == ( 180.0, 1.0, 0.4980392156862745 ))
        #expect(Color.RGBtoHSB(rgb007F00.red, rgb007F00.green, rgb007F00.blue) == ( 120.0, 1.0, 0.4980392156862745 ))
        #expect(Color.RGBtoHSB(rgb00007F.red, rgb00007F.green, rgb00007F.blue) == ( 240.0, 1.0, 0.4980392156862745 ))
    }

    @Test func test_color_RGBtoHSB_total() async throws {
        for value in 0 ... 0xff_ff_ff + 1 {
            let (red, green, blue) = UInt(value).RGB
            let (hue, saturation, brightness) = Color.RGBtoHSB(red, green, blue)
            #expect(hue        >= 0.0  );  if !(hue        >= 0.0  ) { return }
            #expect(hue        <= 360.0);  if !(hue        <= 360.0) { return }
            #expect(saturation >= 0.0  );  if !(saturation >= 0.0  ) { return }
            #expect(saturation <= 1.0  );  if !(saturation <= 1.0  ) { return }
            #expect(brightness >= 0.0  );  if !(brightness >= 0.0  ) { return }
            #expect(brightness <= 1.0  );  if !(brightness <= 1.0  ) { return }
        }
    }

    /* isDark */

    @Test func test_color_isDark_total() async throws {
        var countD: UInt = 0 /* count of dark colors */
        var countL: UInt = 0 /* count of light colors */
        for uintValue in 0 ... 0xff_ff_ff + 1 {
            let color = Color(fromUInt: UInt(uintValue))
            if (color.isDark)
                 { countD += 1 }
            else { countL += 1 }
        }
        #expect(countD == 14680064)
        #expect(countL == 2097153)
    }

}
