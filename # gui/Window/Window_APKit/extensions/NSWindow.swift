
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension NSWindow {

    static var customWindows: [
        String: NSWindow
    ] = [:]

    static func show(ID: String) { Self.customWindows[ID]?.makeKeyAndOrderFront(nil) }
    static func hide(ID: String) { Self.customWindows[ID]?.orderOut(nil) }

    static func makeAndShowFromSwiftUIView(
        ID: String,
        title: String,
        styleMask: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable],
        isVisible: Bool = true,
        level: NSWindow.Level = .normal,
        width: CGFloat = 1000,
        height: CGFloat = 1000,
        isReleasedWhenClosed: Bool = false,
        delegate: any NSWindowDelegate,
        view: NSViewController
    ) {
        if let existingWindow = Self.customWindows[ID] {
            existingWindow.makeKeyAndOrderFront(nil)
            return
        }

        Self.customWindows[ID] = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: width, height: height),
            styleMask: styleMask,
            backing: .buffered,
            defer: false
        )

        guard let window = Self.customWindows[ID] else {
            return
        }

        window.delegate = delegate
        window.contentViewController = MainView()
        window.isReleasedWhenClosed = isReleasedWhenClosed
        window.title = title
        window.level = level

        if (isVisible) {
            Self.show(ID: ID)
            window.center()
        } else {
            Self.hide(ID: ID)
        }
    }

}
