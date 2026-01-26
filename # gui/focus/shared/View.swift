
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

extension View {

    @ViewBuilder func onKeyPressPolyfill(character: String, action: @escaping () -> Void) -> some View {
        if #available(macOS 14.0, *) {
            self.onKeyPress(phases: .down) { press in
                if (press.characters.contains(character)) { action() }
                return .ignored
            }
        } else { self }
    }

}
