
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct Demo_bindingProxy: View {

    @State var isOn: Bool = false

    var body: some View {
        VStack(spacing: 10) {

            /* MARK: Binding Proxy */

            DemoToggle("Binding Proxy: \(isOn)",
                isOn: Binding(
                    get: {                                self.isOn         },
                    set: { value in self.onChange(value); self.isOn = value }
                )
            )

            /* MARK: Binding.proxy */

            DemoToggle("Binding.proxy: \(isOn)",
                isOn: self.$isOn.proxy(self.onChange)
            )

        }
    }

    func onChange(_ value: Bool) {
        print("change: \(value)")
    }

}
