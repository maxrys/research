
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    @Environment(\.openWindow) private var openWindow

    var body: some Scene {
        WindowGroup(for: String.self) { $value in
            if let value {
                /* MARK: Child Windows */
                ContentView(
                    windowId: value
                )
            } else {
                /* MARK: Parent Window */
                VStack {
                    Button("Open Window value=1") { openWindow(value: "value=1") }
                    Button("Open Window value=2") { openWindow(value: "value=2") }
                    Button("Open Window value=3") { openWindow(value: "value=3") }
                    Button("Open Window id=1") { openWindow(id: "id=1") }
                    Button("Open Window id=2") { openWindow(id: "id=2") }
                    Button("Open Window id=3") { openWindow(id: "id=3") }
                }.padding(20)
            }
        }.windowResizability(.contentSize)

        Window("app", id: "id=1") { ContentView(windowId: "id=1") }.windowResizability(.contentSize)
        Window("app", id: "id=2") { ContentView(windowId: "id=1") }.windowResizability(.contentSize)
        Window("app", id: "id=3") { ContentView(windowId: "id=1") }.windowResizability(.contentSize)
    }

}

struct ContentView: View {
    @State private var counter: UInt = 0
    let windowId: String
    var body: some View {
        VStack {
            Text("Window ID: \(self.windowId)")
            Button("Increment") { self.counter += 1 }
            Text("Counter: \(self.counter)")
        }.padding(20)
    }
}
