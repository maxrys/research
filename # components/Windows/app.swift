
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
                    Button("Open Window 1") { openWindow(value: "1") }
                    Button("Open Window 2") { openWindow(value: "2") }
                    Button("Open Window 3") { openWindow(value: "3") }
                }.padding(20)
            }
        }.windowResizability(.contentSize)
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
