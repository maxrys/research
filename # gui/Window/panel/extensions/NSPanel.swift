
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension NSPanel {

    static var customPanels: [
        String: NSPanel
    ] = [:]

    static func get(_ ID: String) -> NSPanel? {
        if let panel = self.customPanels[ID] { return panel }
        return nil
    }

    static func makeNewOrShowExisting<Content: View>(
        ID: String,
        styleMask: NSPanel.StyleMask = [.borderless, .nonactivatingPanel],
        hasShadow: Bool = true,
        isVisible: Bool = true,
        level: NSPanel.Level = .floating,
        size: CGSize = CGSize(width: 1000, height: 1000),
        @ViewBuilder content: () -> Content
    ) -> Bool {

        if let panel = Self.customPanels[ID] {
            panel.show()
            return true
        }

        Self.customPanels[ID] = Self(
            contentRect: NSRect(x: 0, y: 0, width: size.width, height: size.height),
            styleMask: styleMask,
            backing: .buffered,
            defer: false
        )

        guard let panel = Self.customPanels[ID] else {
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

    static func show(_ ID: String) { Self.get(ID)?.makeKeyAndOrderFront(nil) }
    static func hide(_ ID: String) { Self.get(ID)?.orderOut(nil) }

    func show() { self.makeKeyAndOrderFront(nil) }
    func hide() { self.orderOut(nil) }

    var ID: String? {
        self.identifier?.rawValue
    }

}
