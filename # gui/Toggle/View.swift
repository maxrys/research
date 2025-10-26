
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

extension View {

    @ViewBuilder func contentShapePolyfill<S: Shape>(_ shape: S = Capsule()) -> some View {
        if #available(macOS 12.0, *) { self.contentShape(.focusEffect, shape) }
        else                         { self }
    }

}
