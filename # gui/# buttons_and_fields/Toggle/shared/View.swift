
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

extension View {

    @ViewBuilder func pointerStyleLinkPolyfill(isEnabled: Bool = true) -> some View {
        if (isEnabled) {
            if #available(macOS 15.0, *) {
                self.pointerStyle(.link)
            } else {
                self.onHover { isInView in
                    if (isInView) { NSCursor.pointingHand.push() }
                    else          { NSCursor.pop() }
                }
            }
        } else {
            self
        }
    }

}
