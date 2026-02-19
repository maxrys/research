
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        WindowGroup {
            VStack {
                ButtonCustom()
                ButtonCustom(flexibility: .none)
                ButtonCustom(flexibility: .size(100))
                ButtonCustom(flexibility: .infinity)
                ButtonCustom(style: .accent)
                ButtonCustom(style: .danger)
                ButtonCustom(style: .custom)
            }.padding(10)
        }
    }

    init() {
    }

}
