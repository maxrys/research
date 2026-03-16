
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    static public let MAIN_WINDOW_ID = "main"
    static public let MAIN_WINDOW_TITLE = "Main Window"

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        _ = NSWindow.makeAndShowFromSwiftUIView(ID: "id=1", title: "Child Window", isVisible: false, delegate: self, view: ChildView(windowId: "id=1"))
        _ = NSWindow.makeAndShowFromSwiftUIView(ID: "id=2", title: "Child Window", isVisible: false, delegate: self, view: ChildView(windowId: "id=2"))
        _ = NSWindow.makeAndShowFromSwiftUIView(ID: "id=3", title: "Child Window", isVisible: false, delegate: self, view: ChildView(windowId: "id=3"))
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

@main struct ThisApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {

        Window(AppDelegate.MAIN_WINDOW_TITLE, id: AppDelegate.MAIN_WINDOW_ID) {
            MainView()
        }.windowResizability(.contentSize).restorationBehavior(.disabled)

    }

}
