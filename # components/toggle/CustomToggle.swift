
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct CustomToggle: View {

    @Observable final class BoolState {
        var wrappedValue: Bool = false
    }

    var intIsOn: BoolState = Self.BoolState()
    var extIsOn: Binding<Bool>?

    var w: CGFloat = 50
    var h: CGFloat = 30
    var p: CGFloat = 3

    var text: String
    var isFlexible: Bool = false
    var onChange: (Bool) -> Void = { isOn in }

//    init(text: String = "", isFlexible: Bool = false, isOn: Bool, onChange: @escaping (Bool) -> Void = { isOn in }) {
//        self.text = text
//        self.intIsOn.wrappedValue = isOn
//        self.isFlexible = isFlexible
//        self.onChange = onChange
//    }

    init(text: String = "", isFlexible: Bool = false, isOn: Binding<Bool>? = nil, onChange: @escaping (Bool) -> Void = { isOn in }) {
        self.text = text
        self.extIsOn = isOn
        self.isFlexible = isFlexible
        self.onChange = onChange
    }

    var body: some View {
        if (self.isFlexible) {
            HStack {
                Text(self.text)
                    .font(.system(size: 16))
                Spacer()
                self.switcher
            }.frame(maxWidth: .infinity)
        } else {
            HStack {
                Text(self.text)
                    .font(.system(size: 16))
                self.switcher
            }
        }
    }

    @ViewBuilder var switcher: some View {
        var isOn: Bool {
            get { if (self.extIsOn != nil) { self.extIsOn!.wrappedValue            } else { self.intIsOn.wrappedValue } }
            set { if (self.extIsOn != nil) { self.extIsOn!.wrappedValue = newValue } else { self.intIsOn.wrappedValue = newValue } }
        }
        Button {
            self.onChange(!isOn)
            withAnimation(.easeInOut(duration: 0.1)) {
                isOn.toggle()
            }
        } label: {
            Capsule()
                .fill(isOn ? .green : .black.opacity(0.3))
                .frame(width: self.w, height: self.h)
                .overlay(alignment: isOn ? .trailing : .leading) {
                    Circle()
                        .fill(.white)
                        .frame(width: self.h - (self.p * 2), height: self.h - (self.p * 2))
                        .padding(self.p)
                        .shadow(
                            color: .black.opacity(0.5),
                            radius: 2.0
                        )
                }
        }.buttonStyle(.plain)
    }

}

#Preview {
    CustomToggle(
        text: "Test"
    ).frame(width: 100, height: 50)
}
