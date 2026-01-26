
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct DemoToggleOptional: View {

    @Observable final class ValueState<T> {
        var wrappedValue: T
        init(_ value: T) {
            self.wrappedValue = value
        }
    }

    private var text: String
    private var intIsOn = ValueState<Bool>(false)
    private var extIsOn: Binding<Bool>?
    private var onChange: (Bool) -> Void

    init(_ text: String = "", isOn: Binding<Bool>? = nil, onChange: @escaping (Bool) -> Void = { isOn in }) {
        self.text     = text
        self.extIsOn  = isOn
        self.onChange = onChange
    }

    var body: some View {
        var isOn: Bool {
            get { if (self.extIsOn != nil) { self.extIsOn!.wrappedValue            } else { self.intIsOn.wrappedValue            } }
            set { if (self.extIsOn != nil) { self.extIsOn!.wrappedValue = newValue } else { self.intIsOn.wrappedValue = newValue } }
        }
        Button(self.text) {
            isOn.toggle()
            self.onChange(isOn)
        }
    }

}
