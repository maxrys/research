
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var isOn: Bool = false

    var body: some Scene {
        WindowGroup {
            VStack(alignment: .trailing) {
                ToggleCustom(text: "Test", isOn: $isOn, isFlexible: true)
                ToggleCustom(text: "Test", isOn: $isOn, isFlexible: false)
                ToggleCustom(isOn: $isOn)
            }
            .frame(width: 200)
            .padding(20)
        }
    }

}
