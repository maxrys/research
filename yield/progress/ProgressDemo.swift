
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ProgressDemo: View {

    @State private var progress: Double = 0.0

    let count: UInt = 10

    var body: some View {
        VStack {

            ProgressCustom(value: self.$progress)

            Button("start") {
                Task {
                    self.progress = 0
                    for await value in TaskProgress(count: self.count) {
                        self.progress = value
                    }
                }
            }

        }.padding(20)
    }

}
