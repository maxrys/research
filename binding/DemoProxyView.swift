
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct DemoProxyView: View {

    @State var isOn: Bool = false

    var body: some View {
        VStack(spacing: 10) {

            /* MARK: Binding Proxy */
            DemoToggle("Binding Proxy: \(isOn)",
                isOn: Binding(
                    get: {                                    self.isOn         },
                    set: { value in self.onChangeIsOn(value); self.isOn = value }
                )
            )

            /* MARK: Binding.proxy */
            DemoToggle("Binding.proxy: \(isOn)",
                isOn: self.$isOn.proxy(onChangeIsOn)
            )

            Text("Value: \(self.isOn)")

        }
    }

    func onChangeIsOn(_ value: Bool) {
        print("change: \(value)")
    }

}
