
import Testing
import SwiftUI

struct Tests {

    @Test func test_color_fromUInt() async throws {
        for uintValue in 0 ... 0xff { // 0xff_ff_ff + 1
            let color = Color(fromUInt: UInt(uintValue))
            let received = color.uint
            let expected = uintValue
            #expect(received == expected)
            if (received != expected) {
                print("ERROR: \(uintValue)");
                print("RECEIVED:"); dump(received);
                print("EXPECTED:"); dump(expected);
                return
            }
        }
        print("test_color_HSB: OK")
    }

    @Test func test_color_HSB() async throws {
        for uintValue in 0 ... 0xff_ff_ff + 1 {
            _ = Color(fromUInt: UInt(uintValue)).HSB
        }
    }


}
