
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Cocoa

@main final class App: NSObject, NSApplicationDelegate, NSWindowDelegate {

    @MainActor public static var appDelegate: App!

    static func main() {
        let app = NSApplication.shared
        Self.appDelegate = App()
        app.delegate = Self.appDelegate
        app.run()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        _ = NSWindow.makeAndShowFromSwiftUIView(
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
            NSWindow.show("main")
        }
        return true
    }

}
