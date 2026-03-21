
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Cocoa

@main final class App: NSObject, NSApplicationDelegate, NSWindowDelegate {

    static public let MAIN_WINDOW_ID = "main"
    static public let MAIN_WINDOW_TITLE = "Custom Window"

    @MainActor public static var appDelegate: App!

    static func main() {
        let app = NSApplication.shared
        Self.appDelegate = App()
        app.delegate = Self.appDelegate
        app.run()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        _ = NSWindow.makeAndShowFromSwiftUIView(
            ID: Self.MAIN_WINDOW_ID,
            title: Self.MAIN_WINDOW_TITLE,
            delegate: self,
            view: MainScene()
        )
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool { return true }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { return false }
    func applicationShouldHandleReopen(_ app: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if (!flag) {
            NSWindow.get(Self.MAIN_WINDOW_ID)?.show()
        }
        return true
    }

}
