
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct DemoOptionalView: View {

    @State var isOn: Bool = false

    var body: some View {

        /* MARK: isOn = nil */
        DemoToggleOptional(isOn: nil) { isOn in }

        /* MARK: isOn = Binding.constant */
        DemoToggleOptional(isOn: Binding.constant(self.isOn)) { isOn in
            self.isOn = isOn
            self.onChangeIsOn(isOn)
        }

        /* MARK: isOn = Binding */
        DemoToggleOptional(
            isOn: self.$isOn,
            onChange: self.onChangeIsOn
        )

        /* MARK: isOn = Binding Proxy */
        DemoToggleOptional(isOn: Binding<Bool>(
            get: {          self.isOn                                   },
            set: { value in self.isOn = value; self.onChangeIsOn(value) }
        ))

    }

    func onChangeIsOn(_ value: Bool) {
        print("change: \(value)")
    }

}
