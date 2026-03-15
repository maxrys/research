
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public var body: some Scene {
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
                    ButtonCustom(colorStyle: .accent)
                    ButtonCustom(colorStyle: .danger)
                    ButtonCustom(colorStyle: .custom(text: nil, background: nil))
                    ButtonCustom(colorStyle: .custom(text: .white, background: .orange))
                }

            }
            .padding(10)
        }
    }

    init() {
    }

}
