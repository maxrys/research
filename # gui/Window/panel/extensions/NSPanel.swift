
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension NSPanel {

    static func makeNewOrShowExistingPanel<Content: View>(
        ID: String,
        styleMask: NSPanel.StyleMask = [.borderless, .nonactivatingPanel],
        hasShadow: Bool = true,
        isVisible: Bool = true,
        level: NSPanel.Level = .floating,
        size: CGSize = CGSize(width: 1000, height: 1000),
        @ViewBuilder content: () -> Content
    ) -> Bool {

        if let panel = Self.customWindows[ID] {
            panel.show()
            return true
        }

        Self.customWindows[ID] = Self(
            contentRect: CGRect(x: 0, y: 0, width: size.width, height: size.height),
            styleMask: styleMask,
            backing: .buffered,
            defer: false
        )

        guard let panel = Self.customWindows[ID] else {
            return false
        }

        panel.identifier = NSUserInterfaceItemIdentifier(ID)
        panel.isOpaque = false
        panel.backgroundColor = .clear
        panel.hasShadow = hasShadow
        panel.level = level
        panel.contentView = NSHostingView(
            rootView: content()
        )

        if (isVisible)
             { panel.show() }
        else { panel.hide() }

        return true
    }

}
