
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {

            TimelineView(.periodic(from: .now, by: 1.0 / 24)) { context in
                Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .rotationEffect(.degrees(
                        Double(UInt(context.date.timeIntervalSince1970 * 500) % 360)
                    ))
            }

            ProgressDemo()

        }
    }

    init() {
    }

}
