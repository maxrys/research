
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let WINDOW_MAIN_ID = "main"

    @ObservedObject private var frame = ValueState<CGRect>(.zero)

    var body: some Scene {
        Window("Main Window", id: "main") {
            MainScene(self.$frame.value)
        }
     // .windowResizability(.contentSize)
        .restorationBehavior(.disabled)
        .onChange(of: self.frame.value) { _, newValue in
            // save to database
            dump(self.frame.value)
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
