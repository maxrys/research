
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

extension UInt64 {

    func hexEncodedString() -> String {
        String(self, radix: 16)
    }

}
