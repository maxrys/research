
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os
import SwiftUI

@main struct ThisApp: App {

    static let WINDOW_MAIN_ID = "main"

    @AppStorage("frameEncoded") private var frameStored: String = ""
    @ObservedObject private var frame = ValueState<CGRect>(.zero)

    var body: some Scene {
        Window("Main Window", id: "main") {
            MainScene(
                frame              : self.frame.value,
                onFrameManualChange: self.onFrameManualChange
            )
            .onAppear {
                if let window = NSWindow.get(ThisApp.WINDOW_MAIN_ID) {
                    if let storedFrame = CGRect(encoded: self.frameStored) {
                        Task {
                            window.setFrame(storedFrame, display: true, animate: false)
                        }
                    }
                }
            }
        }
        .restorationBehavior(.disabled)
        .onChange(of: self.frame.value) { _, newValue in
            Logger.customLog("Frame change: \(self.frame.value.encode)")
            self.frameStored = newValue.encode
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
        NSWindow.onChangeRect(Self.WINDOW_MAIN_ID) { [self] window in
            self.onFrameChange(newFrame: window.frame)
        }
    }

}
