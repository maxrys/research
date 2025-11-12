
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

    @Test func test_color_toHSB_total() async throws {
        for uintValue in 0 ... 0xff_ff_ff + 1 {
            let (red, green, blue) = Color(fromUInt: UInt(uintValue)).RGBv1
            let (hue, saturation, brightness) = Color.toHSB(red: red, green: green, blue: blue)
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

        #expect(Color.toHSB(red: color_R.RGBv1.red, green: color_R.RGBv1.green, blue: color_R.RGBv1.blue) == (   0.0, 1.0, 1.0 ))
        #expect(Color.toHSB(red: color_G.RGBv1.red, green: color_G.RGBv1.green, blue: color_G.RGBv1.blue) == ( 120.0, 1.0, 1.0 ))
        #expect(Color.toHSB(red: color_B.RGBv1.red, green: color_B.RGBv1.green, blue: color_B.RGBv1.blue) == ( 240.0, 1.0, 1.0 ))
    }

}
