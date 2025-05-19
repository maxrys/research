
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@Observable final class AppState {
    var isOn: Bool = false
}

@main struct app: App {

    @State private var isOn: Bool = false
    private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            VStack(alignment: .leading) {

                let isFlexible = true

                /* MARK: isOn = nil */
                CustomToggle(text: "Custom Toggle (isOn = nil)", isFlexible: isFlexible) { isOn in }

                /* MARK: isOn = Binding.constant */
                CustomToggle(text: "Custom Toggle (isOn = Binding.constant)", isFlexible: isFlexible, isOn: Binding.constant(self.isOn)) { isOn in
                    self.isOn = isOn
                }

                /* MARK: isOn = Binding Proxy */

                CustomToggle(text: "Custom Toggle (Binding Proxy)", isFlexible: isFlexible, isOn: self.$isOn) { isOn in }

                CustomToggle(text: "Custom Toggle (Binding Proxy)", isFlexible: isFlexible, isOn: self.$isOn.proxy({ oldValue, newValue in }))

                CustomToggle(text: "Custom Toggle (Binding Proxy)", isFlexible: isFlexible, isOn: Binding<Bool>(
                    get: {             self.appState.isOn            },
                    set: { newValue in self.appState.isOn = newValue }
                ))

                /* MARK: Original Toggle */

                Toggle("Original Toggle", isOn: self.$isOn)

                Toggle("Original Toggle", isOn: self.$isOn.proxy({ oldValue, newValue in }))

                Toggle("Original Toggle", isOn: Binding<Bool>(
                    get: {             self.appState.isOn            },
                    set: { newValue in self.appState.isOn = newValue }
                ))

            }.frame(maxWidth: 400)
        }
    }

    init() {

    }

}
