
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
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

@main struct ThisApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {

        Window("Main Window", id: "main") {
            MainView()
        }.windowResizability(.contentSize).restorationBehavior(.disabled)

    }

}
