
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {

            TabView {
                Tab("SnapToGrid"   , systemImage: "4.square.fill") { SnapToGrid() }
                Tab("SnapToElement", systemImage: "5.square.fill") { SnapToElement() }
            }

        }.windowResizability(.contentSize)
    }

}
