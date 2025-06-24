
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    @Environment(\.openWindow) private var openWindow

    var body: some Scene {
        WindowGroup(for: String.self) { $windowId in
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
    @State private var value: UInt = 0
    let windowId: String
    var body: some View {
        VStack {
            Text("Window ID: \(self.windowId)")
            Button("Increment") { self.value += 1 }
            Text("Counter: \(self.value)")
        }.padding(20)
    }
}
