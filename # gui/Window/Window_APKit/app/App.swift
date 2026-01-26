
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Cocoa

class ThisApp: NSObject, NSApplicationDelegate, NSWindowDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSWindow.makeAndShowFromSwiftUIView(
            ID: "main",
            title: "Custom Window",
            delegate: self,
            view: MainView()
        )
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    func applicationShouldHandleReopen(_ app: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if (!flag) {
            NSWindow.show(ID: "main")
        }
        return true
    }

}
