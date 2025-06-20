
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct WindowInfo: Identifiable {
    var id: String = ""
}

@main struct app: App {

    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openWindow) private var openWindow

    var body: some Scene {
        WindowGroup(for: WindowInfo.ID.self) { $windowId in
            if let windowId {
                /* MARK: Child Windows */
                ContentView(
                    windowId: windowId
                )
            } else {
                /* MARK: Parent Window */
                VStack {
                    Button("Open in New Window 1") { openWindow(value: "1") }
                    Button("Open in New Window 2") { openWindow(value: "2") }
                    Button("Open in New Window 3") { openWindow(value: "3") }
                }.padding(20)
            }
        }.windowResizability(.contentSize)
    }

}

struct ContentView: View {
    let windowId: WindowInfo.ID
    var body: some View {
        Text("Window ID: \(self.windowId)")
            .padding(20)
    }
}
