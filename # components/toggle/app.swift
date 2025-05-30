
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    @State private var isOn: Bool = false

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

                /* MARK: isOn = Binding */
                CustomToggle(text: "Custom Toggle (Binding)", isFlexible: isFlexible, isOn: self.$isOn) { isOn in }

                /* MARK: isOn = Binding Proxy */
                CustomToggle(text: "Custom Toggle (Binding Proxy)", isFlexible: isFlexible, isOn: Binding<Bool>(
                    get: {             self.isOn            },
                    set: { newValue in self.isOn = newValue }
                ))

            }.frame(maxWidth: 400)
        }
    }

    init() {

    }

}
