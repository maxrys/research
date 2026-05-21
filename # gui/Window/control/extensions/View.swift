
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension View {

    @ViewBuilder func onWinResize(_ action: @escaping (NSWindow) -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: NSWindow.didResizeNotification),
            perform: { info in
                if let window = info.object as? NSWindow {
                    action(window)
                }
            }
        )
    }

    @ViewBuilder func onWinMove(_ action: @escaping (NSWindow) -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: NSWindow.didMoveNotification),
            perform: { info in
                if let window = info.object as? NSWindow {
                    action(window)
                }
            }
        )
    }

}
