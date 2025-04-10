
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

extension Data {

    var stringUTF8: String? {
        return String(data: self, encoding: .utf8)
    }

}
