
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    @State var isOn: Bool = false

    var body: some Scene {
        WindowGroup {
            let bindingProxy: Binding<Bool> = Binding(
                get: {                                    self.isOn         },
                set: { value in self.onChangeIsOn(value); self.isOn = value }
            )
            CustomToggle(
                isOn: bindingProxy
            )
        }
    }

    func onChangeIsOn(_ value: Bool) {
        print("change: \(value)")
    }

    init() {
    }

}

struct CustomToggle: View {

    var isOn: Binding<Bool>
    var body: some View {
        Button("State: \(self.isOn.wrappedValue)") {
            self.isOn.wrappedValue.toggle()
        }
    }

}
