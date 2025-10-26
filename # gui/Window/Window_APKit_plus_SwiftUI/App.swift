
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Cocoa
import SwiftUI

class ThisApp: NSObject, NSApplicationDelegate, NSWindowDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainView = MainView()
        let mainHostingView = NSHostingView(rootView: mainView)

        self.window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )

        self.window.center()
        self.window.title = "SwiftUI in AppKit"
        self.window.level = .normal
        self.window.makeKeyAndOrderFront(nil)
        self.window.contentView = mainHostingView
        self.window.delegate = self
        self.window.center()

        mainHostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainHostingView.leadingAnchor .constraint(equalTo: self.window.contentView!.leadingAnchor),
            mainHostingView.trailingAnchor.constraint(equalTo: self.window.contentView!.trailingAnchor),
            mainHostingView.topAnchor     .constraint(equalTo: self.window.contentView!.topAnchor),
            mainHostingView.bottomAnchor  .constraint(equalTo: self.window.contentView!.bottomAnchor),
        ])
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}
