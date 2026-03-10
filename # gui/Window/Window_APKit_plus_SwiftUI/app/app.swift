
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Cocoa

@main final class App: NSObject, NSApplicationDelegate, NSWindowDelegate {

    @MainActor private static var appDelegate: App!

    static func main() {
        let app = NSApplication.shared
        Self.appDelegate = App()
        app.delegate = Self.appDelegate
        app.run()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSWindow.makeAndShowFromSwiftUIView(ID: "main", title: "Main Window" , isVisible: true , delegate: self, view: MainView())
        NSWindow.makeAndShowFromSwiftUIView(ID: "id=1", title: "Child Window", isVisible: false, delegate: self, view: ChildView(windowId: "id=1"))
        NSWindow.makeAndShowFromSwiftUIView(ID: "id=2", title: "Child Window", isVisible: false, delegate: self, view: ChildView(windowId: "id=2"))
        NSWindow.makeAndShowFromSwiftUIView(ID: "id=3", title: "Child Window", isVisible: false, delegate: self, view: ChildView(windowId: "id=3"))
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    func applicationShouldHandleReopen(_ app: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        // if (!flag) {
            NSWindow.show(ID: "main")
        // }
        return true
    }

}
