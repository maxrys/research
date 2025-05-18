
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Testing
import Foundation

struct test {

    @Test func test_to_UInt64() async throws {
        let data: [UInt64: (value: Data, expected: UInt64?)] = [
                             2: (value: Data([ 0x90, 0x80, 0x70, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10 ]), expected:                nil),
            0x8070605040302010: (value: Data([       0x80, 0x70, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10 ]), expected: 0x8070605040302010),
              0x70605040302010: (value: Data([             0x70, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10 ]), expected:   0x70605040302010),
                0x605040302010: (value: Data([                   0x60, 0x50, 0x40, 0x30, 0x20, 0x10 ]), expected:     0x605040302010),
                  0x5040302010: (value: Data([                         0x50, 0x40, 0x30, 0x20, 0x10 ]), expected:       0x5040302010),
                    0x40302010: (value: Data([                               0x40, 0x30, 0x20, 0x10 ]), expected:         0x40302010),
                      0x302010: (value: Data([                                     0x30, 0x20, 0x10 ]), expected:           0x302010),
                        0x2010: (value: Data([                                           0x20, 0x10 ]), expected:             0x2010),
                          0x10: (value: Data([                                                 0x10 ]), expected:               0x10),
            0xffffffffffffffff: (value: Data([       0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff ]), expected: 0xffffffffffffffff),
                             0: (value: Data([       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ]), expected:                  0),
                             1: (value: Data([                                                      ]), expected:                  0),
        ]

        for (key, item) in data {
            let received: UInt64? = item.value.UInt64
            let expected: UInt64? = item.expected
            #expect(received == expected)
            if (received == expected) { print(    "OK: \(key)" ) }
            else                      { print( "ERROR: \(key)" ); print("RECEIVED:"); dump(received); print("EXPECTED:"); dump(expected) }
        }
    }

    @Test func test_init_fromUInt16() async throws {
        let data: [UInt64: (received: Data, expected: Data)] = [
                     0: (received: Data(fromUInt16: [                UInt16(     0)]), expected: Data([               0,    0])),
                  0x10: (received: Data(fromUInt16: [                UInt16(  0x10)]), expected: Data([               0, 0x10])),
                0x2010: (received: Data(fromUInt16: [                UInt16(0x2010)]), expected: Data([            0x20, 0x10])),
              0x302010: (received: Data(fromUInt16: [UInt16(  0x30), UInt16(0x2010)]), expected: Data([   0, 0x30, 0x20, 0x10])),
            0x40302010: (received: Data(fromUInt16: [UInt16(0x4030), UInt16(0x2010)]), expected: Data([0x40, 0x30, 0x20, 0x10])),
        ]

        for (key, item) in data {
            let received = item.received
            let expected = item.expected
            #expect(received == expected)
            if (received == expected) { print(    "OK: \(key)" ) }
            else                      { print( "ERROR: \(key)" ); print("RECEIVED:"); dump(received); print("EXPECTED:"); dump(expected) }
        }
    }

    @Test func test_init_fromUInt32() async throws {
        let data: [UInt64: (received: Data, expected: Data)] = [
                             0: (received: Data(fromUInt32: [                    UInt32(         0)]), expected: Data([                            0,    0,    0,    0])),
                          0x10: (received: Data(fromUInt32: [                    UInt32(      0x10)]), expected: Data([                            0,    0,    0, 0x10])),
                        0x2010: (received: Data(fromUInt32: [                    UInt32(    0x2010)]), expected: Data([                            0,    0, 0x20, 0x10])),
                      0x302010: (received: Data(fromUInt32: [                    UInt32(  0x302010)]), expected: Data([                            0, 0x30, 0x20, 0x10])),
                    0x40302010: (received: Data(fromUInt32: [                    UInt32(0x40302010)]), expected: Data([                         0x40, 0x30, 0x20, 0x10])),
                  0x5040302010: (received: Data(fromUInt32: [UInt32(      0x50), UInt32(0x40302010)]), expected: Data([    0,    0,    0, 0x50, 0x40, 0x30, 0x20, 0x10])),
                0x605040302010: (received: Data(fromUInt32: [UInt32(    0x6050), UInt32(0x40302010)]), expected: Data([    0,    0, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10])),
              0x70605040302010: (received: Data(fromUInt32: [UInt32(  0x706050), UInt32(0x40302010)]), expected: Data([    0, 0x70, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10])),
            0x8070605040302010: (received: Data(fromUInt32: [UInt32(0x80706050), UInt32(0x40302010)]), expected: Data([ 0x80, 0x70, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10])),
        ]

        for (key, item) in data {
            let received = item.received
            let expected = item.expected
            #expect(received == expected)
            if (received == expected) { print(    "OK: \(key)" ) }
            else                      { print( "ERROR: \(key)" ); print("RECEIVED:"); dump(received); print("EXPECTED:"); dump(expected) }
        }
    }

    @Test func test_init_fromUInt64() async throws {
        let data: [UInt64: (received: Data, expected: Data)] = [
                             0: (received: Data(fromUInt64: [              UInt64(                 0)]), expected: Data([                              0,    0,    0,    0,    0,    0,    0,    0])),
                          0x10: (received: Data(fromUInt64: [              UInt64(              0x10)]), expected: Data([                              0,    0,    0,    0,    0,    0,    0, 0x10])),
                        0x2010: (received: Data(fromUInt64: [              UInt64(            0x2010)]), expected: Data([                              0,    0,    0,    0,    0,    0, 0x20, 0x10])),
                      0x302010: (received: Data(fromUInt64: [              UInt64(          0x302010)]), expected: Data([                              0,    0,    0,    0,    0, 0x30, 0x20, 0x10])),
                    0x40302010: (received: Data(fromUInt64: [              UInt64(        0x40302010)]), expected: Data([                              0,    0,    0,    0, 0x40, 0x30, 0x20, 0x10])),
                  0x5040302010: (received: Data(fromUInt64: [              UInt64(      0x5040302010)]), expected: Data([                              0,    0,    0, 0x50, 0x40, 0x30, 0x20, 0x10])),
                0x605040302010: (received: Data(fromUInt64: [              UInt64(    0x605040302010)]), expected: Data([                              0,    0, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10])),
              0x70605040302010: (received: Data(fromUInt64: [              UInt64(  0x70605040302010)]), expected: Data([                              0, 0x70, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10])),
            0x8070605040302010: (received: Data(fromUInt64: [              UInt64(0x8070605040302010)]), expected: Data([                           0x80, 0x70, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10])),
            0xffffffffffffffff: (received: Data(fromUInt64: [UInt64(0x90), UInt64(0x8070605040302010)]), expected: Data([0, 0, 0, 0, 0, 0, 0, 0x90, 0x80, 0x70, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10])),
        ]

        for (key, item) in data {
            let received = item.received
            let expected = item.expected
            #expect(received == expected)
            if (received == expected) { print(    "OK: \(key)" ) }
            else                      { print( "ERROR: \(key)" ); print("RECEIVED:"); dump(received); print("EXPECTED:"); dump(expected) }
        }
    }

}
