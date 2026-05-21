
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension View {

    @ViewBuilder func onAppBecomeBackground(_ action: @escaping () -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: NSApplication.didResignActiveNotification),
            perform: { _ in
                action()
            }
        )
    }

    @ViewBuilder func onAppBecomeForeground(_ action: @escaping () -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification),
            perform: { _ in
                action()
            }
        )
    }

    @ViewBuilder func onWinBecomeForeground(_ action: @escaping (NSWindow) -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: NSWindow.didBecomeMainNotification),
            perform: { info in
                if let window = info.object as? NSWindow {
                    action(window)
                }
            }
        )
    }

    @ViewBuilder func onWinBecomeBackground(_ action: @escaping (NSWindow) -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: NSWindow.didResignMainNotification),
            perform: { info in
                if let window = info.object as? NSWindow {
                    action(window)
                }
            }
        )
    }

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
