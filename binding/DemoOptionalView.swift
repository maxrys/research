
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct DemoOptionalView: View {

    @State var isOn: Bool = false

    var body: some View {
        VStack(spacing: 10) {

            /* MARK: Binding = nil */
            DemoToggleOptional("Binding = nil", isOn: nil) { isOn in }

            /* MARK: Binding.constant */
            DemoToggleOptional("Binding.constant: \(isOn)",
                isOn: Binding.constant(self.isOn)) { isOn in
                    self.isOn = !isOn
                    self.onChangeIsOn(self.isOn)
                }

            /* MARK: Binding Classic */
            DemoToggleOptional("Binding Classic: \(isOn)",
                isOn    : self.$isOn,
                onChange: self.onChangeIsOn
            )

            Text("Value: \(self.isOn)")

        }.padding(20)
    }

    func onChangeIsOn(_ value: Bool) {
        print("change: \(value)")
    }

}
