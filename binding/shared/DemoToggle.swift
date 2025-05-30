
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct DemoToggle: View {

    var isOn: Binding<Bool>

    var body: some View {
        Button("State: \(self.isOn.wrappedValue)") {
            self.isOn.wrappedValue.toggle()
        }
    }

}
