
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

extension View {

    @ViewBuilder func focusEffect<S>(_ shape: S) -> some View where S: Shape {
        if #available(macOS 12.0, *) {
            self.contentShape(.focusEffect, shape)
        } else {
            self
        }
    }

}
