
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation
import CryptoKit

extension Data {

    var UInt64: UInt64? {
        get {
            guard self.count <= 8 else {
                return nil
            }
            var result: UInt64 = 0
            for i in 0 ..< self.count {
                result = result | Swift.UInt64(self[i])
                if i != self.count - 1 {
                    result = result << 8
                }
            }
            return result
        }
    }

    init(fromUInt16 data: [UInt16]) {
        self.init(count: data.count * 2)
        for i in 0 ..< data.count {
            self[i * 2 + 1] = UInt8(data[i]      & 0b11111111)
            self[i * 2 + 0] = UInt8(data[i] >> 8 & 0b11111111)
        }
    }

    init(fromUInt32 data: [UInt32]) {
        self.init(count: data.count * 4)
        for i in 0 ..< data.count {
            self[i * 4 + 3] = UInt8(data[i]       & 0b11111111)
            self[i * 4 + 2] = UInt8(data[i] >>  8 & 0b11111111)
            self[i * 4 + 1] = UInt8(data[i] >> 16 & 0b11111111)
            self[i * 4 + 0] = UInt8(data[i] >> 24 & 0b11111111)
        }
    }

    init(fromUInt64 data: [UInt64]) {
        self.init(count: data.count * 8)
        for i in 0 ..< data.count {
            self[i * 8 + 7] = UInt8(data[i]       & 0b11111111)
            self[i * 8 + 6] = UInt8(data[i] >>  8 & 0b11111111)
            self[i * 8 + 5] = UInt8(data[i] >> 16 & 0b11111111)
            self[i * 8 + 4] = UInt8(data[i] >> 24 & 0b11111111)
            self[i * 8 + 3] = UInt8(data[i] >> 32 & 0b11111111)
            self[i * 8 + 2] = UInt8(data[i] >> 40 & 0b11111111)
            self[i * 8 + 1] = UInt8(data[i] >> 48 & 0b11111111)
            self[i * 8 + 0] = UInt8(data[i] >> 56 & 0b11111111)
        }
    }

    init?(hexEncoded hex: String) {
        guard hex.count % 2 == 0 else {
            return nil
        }

        self.init(
            count: hex.count / 2
        )

        let charToValue = { (_ char:Character) -> UInt8? in
            switch char {
                case "0"..."9": return char.asciiValue! - 48      // "0" == 48
                case "A"..."F": return char.asciiValue! - 65 + 10 // "A" == 65
                case "a"..."f": return char.asciiValue! - 97 + 10 // "a" == 97
                default       : return nil
            }
        }

        for i in 0..<hex.count / 2 {
            let value1 = charToValue(hex[hex.index(hex.startIndex, offsetBy: i * 2 + 0)])
            let value2 = charToValue(hex[hex.index(hex.startIndex, offsetBy: i * 2 + 1)])
            guard value1 != nil else {return nil}
            guard value2 != nil else {return nil}
            self[i] = value1! * 16 + value2!
        }
    }

    func hexEncodedString() -> String {
        var result = ""
        for byte in self {
            if byte > 0xf {result +=       String(byte, radix: 16)}
            else          {result += "0" + String(byte, radix: 16)}
        }
        return result
    }

    func sha256() -> Data {
        let hash = SHA256.hash(data: self)
        return Data(hash)
    }

    var stringUTF8: String? {
        return String(data: self, encoding: .utf8)
    }

}
