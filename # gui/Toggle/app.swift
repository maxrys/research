
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var isOn: Bool = false

    var body: some Scene {
        WindowGroup {
            VStack(alignment: .leading) {

                ToggleCustom(text: "Custom Toggle", isFlexible: true, isOn: self.$isOn) { isOn in }
                ToggleCustom(text: "Custom Toggle", isFlexible: true, isOn: self.$isOn) { isOn in }
                ToggleCustom(text: "Custom Toggle", isFlexible: true, isOn: self.$isOn) { isOn in }

            }.frame(maxWidth: 300)
        }
    }

    init() {

    }

}
