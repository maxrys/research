
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension NSWindow {

    static var customWindows: [
        String: NSWindow
    ] = [:]

    static func makeAndShowFromSwiftUIView(
        ID: String,
        title: String,
        styleMask: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable],
        isVisible: Bool = true,
        level: NSWindow.Level = .normal,
        size: CGSize = CGSize(width: 1000, height: 1000),
        isReleasedWhenClosed: Bool = false,
        delegate: any NSWindowDelegate,
        view: NSViewController
    ) -> Bool {
        if let window = Self.customWindows[ID] {
            window.show()
            return true
        }

        Self.customWindows[ID] = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: size.width, height: size.height),
            styleMask: styleMask,
            backing: .buffered,
            defer: false
        )

        guard let window = Self.customWindows[ID] else {
            return false
        }

        window.identifier = NSUserInterfaceItemIdentifier(ID)
        window.delegate = delegate
        window.contentViewController = view
        window.isReleasedWhenClosed = isReleasedWhenClosed
        window.title = title
        window.level = level

        if (isVisible) {
            window.show()
            window.center()
        } else {
            window.hide()
        }
        return true
    }

    static func show(_ ID: String) { self.customWindows[ID]?.makeKeyAndOrderFront(nil) }
    static func hide(_ ID: String) { self.customWindows[ID]?.orderOut(nil) }

    func show() { self.makeKeyAndOrderFront(nil) }
    func hide() { self.orderOut(nil) }

    var ID: String? {
        self.identifier?.rawValue
    }

}
