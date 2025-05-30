
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct DemoProxyView: View {

    @State var isOn: Bool = false

    var body: some View {

        /* MARK: Binding Proxy */
        DemoToggle(
            isOn: Binding(
                get: {                                    self.isOn         },
                set: { value in self.onChangeIsOn(value); self.isOn = value }
            )
        )

        /* MARK: Binding.proxy */
        DemoToggle(
            isOn: self.$isOn.proxy(onChangeIsOn)
        )

    }

    func onChangeIsOn(_ value: Bool) {
        print("change: \(value)")
    }

}
