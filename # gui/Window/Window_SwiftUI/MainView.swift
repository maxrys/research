
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct MainView: View {

    @Environment(\.openWindow)    private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        VStack {
            Button("Open Window ID = 1") { openWindow(id: "ID=1") }
            Button("Open Window ID = 2") { openWindow(id: "ID=2") }
            Button("Open Window ID = 3") { openWindow(id: "ID=3") }
            Button("Open Window Value = 1") { openWindow(value: "Value=1") }
            Button("Open Window Value = 2") { openWindow(value: "Value=2") }
            Button("Open Window Value = 3") { openWindow(value: "Value=3") }
        }
        .padding(20)
     // .onAppear {
     //     dismissWindow(id: "id=1")
     //     dismissWindow(id: "id=2")
     //     dismissWindow(id: "id=3")
     //     dismissWindow(value: "value=1")
     //     dismissWindow(value: "value=2")
     //     dismissWindow(value: "value=3")
     // }
    }

}
