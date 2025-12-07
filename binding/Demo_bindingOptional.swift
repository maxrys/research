
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct Demo_bindingOptional: View {

    @State var isOn: Bool = false

    var body: some View {
        VStack(spacing: 10) {

            /* MARK: Binding = nil */

            DemoToggleOptional("Binding = nil",
                isOn: nil,
                onChange: self.onChange
            )

            /* MARK: Binding.constant */

            DemoToggleOptional("Binding.constant: \(isOn)",
                isOn: Binding.constant(self.isOn)) { isOn in
                    self.isOn = !isOn
                    self.onChange(self.isOn)
                }

            /* MARK: Binding Classic */

            DemoToggleOptional("Binding Classic: \(isOn)",
                isOn    : self.$isOn,
                onChange: self.onChange
            )

        }.padding(20)
    }

    func onChange(_ value: Bool) {
        print("change: \(value)")
    }

}
