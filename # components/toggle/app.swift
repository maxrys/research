
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    @State private var isOn1: Bool = false
    @State private var isOn2: Bool = false

    var body: some Scene {
        WindowGroup {
            VStack(alignment: .leading) {

                let isFlexible = true

                /* MARK: isOn = nil */
                CustomToggle(text: "Custom Toggle (isOn = nil)", isFlexible: isFlexible) { isOn in
                }

                /* MARK: isOn = Bool */
                CustomToggle(text: "Custom Toggle (isOn = Bool.true)", isOn: true, isFlexible: isFlexible) { isOn in
                }

                /* MARK: isOn = Binding.constant */
                CustomToggle(text: "Custom Toggle (isOn = Binding.constant)", isOn: Binding.constant(true), isFlexible: isFlexible) { isOn in
                }

                /* MARK: isOn = Binding */
                CustomToggle(text: "Custom Toggle (isOn = Binding)", isOn: self.$isOn1, isFlexible: isFlexible) { isOn in
                }

                /* MARK: isOn = State */
                CustomToggle(text: "Custom Toggle (isOn = State)", isOn: self.isOn2, isFlexible: isFlexible) { isOn in
                    self.isOn2 = isOn
                }

            }.frame(width: 400)
        }
    }

    init() {

    }

}
