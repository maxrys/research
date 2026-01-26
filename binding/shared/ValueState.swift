
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@Observable final class ValueState<T> {
    var wrappedValue: T
    init(_ value: T) {
        self.wrappedValue = value
    }
}
