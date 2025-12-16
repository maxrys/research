
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ProgressDemo: View {

    @State private var progress: Double = 0.0

    let totalSteps = 10

    var body: some View {
        VStack {
            ProgressCustom(value: self.$progress)
            Button("start") {
                Task {
                    for await value in TaskProgress(totalSteps: self.totalSteps) {
                        self.progress = value
                    }
                }
            }
        }.padding(20)
    }

}
