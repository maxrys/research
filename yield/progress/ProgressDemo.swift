
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ProgressDemo: View {

    @State private var progress: Double = 0.0

    var body: some View {
        VStack {
            ProgressCustom(value: progress)
            Button("start") {
                Task {
                    for await value in TaskProgress(totalSteps: 10) {
                        self.progress = value
                        print(value)
                    }
                }
            }
        }.padding(20)
    }

}
