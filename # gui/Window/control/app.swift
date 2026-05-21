
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os
import SwiftUI

@main struct ThisApp: App {

    static let WINDOW_MAIN_ID = "main"

    @ObservedObject private var frame = ValueState<CGRect>(.zero)

    var body: some Scene {
        Window("Main Window", id: "main") {
            MainScene(
                frame: self.frame.value,
                onManualChangeFrame: self.onManualChangeFrame
            )
        }
     // .windowResizability(.contentSize)
        .restorationBehavior(.disabled)
        .onChange(of: self.frame.value) { _, newValue in
            Logger.customLog("Frame change: x = \(self.frame.value.x) | y = \(self.frame.value.y) | w = \(self.frame.value.w) | h = \(self.frame.value.h)")
        }
    }

    func onManualChangeFrame(newFrame: CGRect) {
        self.frame.value = newFrame
        if let window = NSWindow.get(ThisApp.WINDOW_MAIN_ID) {
            window.setFrame(newFrame, display: true, animate: true)
        }
    }

    init() {
        NSWindow.onChangeRect(Self.WINDOW_MAIN_ID) { [weak frame] window in
            Task { @MainActor in
                frame?.value = window.frame
            }
        }
    }

}
