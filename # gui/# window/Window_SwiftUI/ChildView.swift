
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ChildView: View {

    @State private var counter: UInt = 0

    let windowId: String

    var body: some View {
        VStack {

            Text("Window ID: \(self.windowId)")

            Button("Increment") {
                self.counter += 1
            }

            Text("Counter: \(self.counter)")

        }.padding(20)
    }

}
