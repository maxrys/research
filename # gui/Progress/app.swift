
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public var body: some Scene {
        WindowGroup {
            VStack(spacing: 10) {
                ForEach(Array(stride(from: -0.1, through: 1.1, by: 0.1)), id: \.self) { value in
                    ProgressCustom(
                        value: .constant(value)
                    )
                }
            }
            .padding(10)
        }
    }

}
