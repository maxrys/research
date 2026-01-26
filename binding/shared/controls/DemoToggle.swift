
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct DemoToggle: View {

    @Binding private var isOn: Bool

    private var text: String

    init(_ text: String = "", isOn: Binding<Bool>) {
        self.text = text
        self._isOn = isOn
    }

    var body: some View {
        Button(self.text) {
            self.isOn.toggle()
        }
    }

}
