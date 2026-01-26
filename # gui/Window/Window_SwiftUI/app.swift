
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {

        Window("Main Window", id: "main") {
            MainView()
        }.windowResizability(.contentSize).restorationBehavior(.disabled)

        /* MARK: Window with Static ID */

        Window("Child Window", id: "ID=1") {
            ChildView(windowId: "ID=1")
        }.windowResizability(.contentSize).restorationBehavior(.disabled)

        Window("Child Window", id: "ID=2") {
            ChildView(windowId: "ID=2")
        }.windowResizability(.contentSize).restorationBehavior(.disabled)

        Window("Child Window", id: "ID=3") {
            ChildView(windowId: "ID=3")
        }.windowResizability(.contentSize).restorationBehavior(.disabled)

        /* MARK: Window with Dynamic ID */

        WindowGroup("Child Window", for: String.self) { $value in
            if let value { ChildView(windowId: value) }
        }.windowResizability(.contentSize).restorationBehavior(.disabled)

    }

}
