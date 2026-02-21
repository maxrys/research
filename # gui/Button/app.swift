
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {

                VStack {
                    Text("flexibility").font(.headline)
                    ButtonCustom()
                    ButtonCustom(flexibility: .none)
                    ButtonCustom(flexibility: .size(100))
                    ButtonCustom(flexibility: .infinity)
                }

                VStack {
                    Text("style").font(.headline)
                    ButtonCustom(style: .accent)
                    ButtonCustom(style: .danger)
                    ButtonCustom(style: .custom(text: nil, background: nil))
                    ButtonCustom(style: .custom(text: .white, background: .orange))
                }

            }
            .padding(10)
        }
    }

    init() {
    }

}
