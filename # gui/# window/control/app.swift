
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Logger.customLog("AppDelegate.applicationDidFinishLaunching()")
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { false }
}

@main struct ThisApp: App {

    static let WINDOW_MAIN_ID = "main"

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("frameEncoded") private var frameStored: String = ""
    @ObservedObject private var frame = ValueState<CGRect>(.zero)

    var body: some Scene {
        Window("Main Window", id: "main") {
            MainScene(
                frame              : self.frame.value,
                onFrameManualChange: self.onFrameManualChange
            )
            .onAppear {
                Logger.customLog("MainScene.onAppear()")
                if let window = NSWindow.get(ThisApp.WINDOW_MAIN_ID) {
                    if let storedFrame = CGRect(decode: self.frameStored) {
                        if (window.frame != storedFrame) {
                            Task { @MainActor in
                                window.setFrame(storedFrame, display: true, animate: true)
                                Logger.customLog("Frame restore")
                            }
                        }
                    }
                }
            }
        }
     // .restorationBehavior(.disabled)
        .onChange(of: self.frame.value) { _, newValue in
            Logger.customLog("Frame change: \(self.frame.value.encode())")
            self.frameStored = newValue.encode()
        }
    }

    func onFrameManualChange(newFrame: CGRect) {
        self.frame.value = newFrame
        if let window = NSWindow.get(ThisApp.WINDOW_MAIN_ID) {
            window.setFrame(newFrame, display: true, animate: true)
        }
    }

    func onFrameChange(newFrame: CGRect) {
        self.frame.value = newFrame
    }

    init() {
        Logger.customLog("App.init()")
        NSWindow.onChangeRect(Self.WINDOW_MAIN_ID) { [self] window in
            self.onFrameChange(newFrame: window.frame)
        }
    }

}
