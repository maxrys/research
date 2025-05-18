
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct CustomToggle: View {

    @Observable final class BoolState {
        var wrappedValue: Bool = false
    }

    var intIsOn: BoolState = BoolState()
    var extIsOn: Binding<Bool>?

    var text: String
    var isFlexible: Bool = false
    var onChange: (Bool) -> Void = { isOn in }

    init(text: String = "", isOn: Bool, isFlexible: Bool = false, onChange: @escaping (Bool) -> Void = { isOn in }) {
        self.text = text
        self.intIsOn.wrappedValue = isOn
        self.isFlexible = isFlexible
        self.onChange = onChange
    }

    init(text: String = "", isOn: Binding<Bool>? = nil, isFlexible: Bool = false, onChange: @escaping (Bool) -> Void = { isOn in }) {
        self.text = text
        self.extIsOn = isOn
        self.isFlexible = isFlexible
        self.onChange = onChange
    }

    var body: some View {
        if (self.isFlexible)
             { self.component.frame(maxWidth: .infinity) }
        else { self.component }
    }

    @ViewBuilder var component: some View {
        var isOn: Bool {
            get { if (self.extIsOn != nil) { self.extIsOn!.wrappedValue            } else { self.intIsOn.wrappedValue } }
            set { if (self.extIsOn != nil) { self.extIsOn!.wrappedValue = newValue } else { self.intIsOn.wrappedValue = newValue } }
        }
        HStack {
            Text(self.text)
                .font(.system(size: 16))
            if (self.isFlexible) {
                Spacer()
            }
            Button {
                self.onChange(!isOn)
                withAnimation(.easeInOut(duration: 0.1)) {
                    isOn.toggle()
                }
            } label: {
                Capsule()
                    .fill(isOn ? .green : .black.opacity(0.3))
                    .frame(width: 50, height: 30)
                    .overlay(alignment: isOn ? .trailing : .leading) {
                        Circle()
                            .fill(.white)
                            .frame(width: 24, height: 24)
                            .padding(3)
                            .shadow(
                                color: .black.opacity(0.5),
                                radius: 2.0
                            )
                    }
            }
            .buttonStyle(.plain)
        }
    }

}

#Preview {
    CustomToggle(
        text: "Test"
    ).frame(width: 100, height: 50)
}
