
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let WINDOW_MAIN_ID = "main"

    @State private var windowMainFrame = ValueState<CGRect>(.zero)

    init() {
        NSWindow.onChangeRect(ThisApp.WINDOW_MAIN_ID) { [self] window in
            self.windowMainFrame.value = window.frame
        }
    }

    var body: some Scene {
        Window("Main Window", id: Self.WINDOW_MAIN_ID) { MainScene(windowMainFrame: self.$windowMainFrame.value) }
            .windowResizability(.automatic)
            .restorationBehavior(.disabled)
    }

}
