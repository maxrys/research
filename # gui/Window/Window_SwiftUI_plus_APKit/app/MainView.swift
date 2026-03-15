
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct MainView: View {

    var body: some View {
        VStack {
            Button("Open Window ID = 1") { NSWindow.show("id=1") }
            Button("Open Window ID = 2") { NSWindow.show("id=2") }
            Button("Open Window ID = 3") { NSWindow.show("id=3") }
            Button("Hide Window with animation") { NSWindow.hideWithAnimation(AppDelegate.MAIN_WINDOW_ID) }
            Button("Hide Title Icons") { NSWindow.get(AppDelegate.MAIN_WINDOW_ID)?.hideTitleButtons(isVisible: false) }
        }
        .padding(20)
        .frame(width: 300)
        .onAppear {
            NSWindow.hide("id=1")
            NSWindow.hide("id=2")
            NSWindow.hide("id=3")
        }
    }

}
