
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct CustomToggle: View {

    private var isOn: Binding<Bool>

    var w: CGFloat = 50
    var h: CGFloat = 30
    var p: CGFloat = 3

    var text: String
    var isFlexible: Bool = false
    var onChange: (Bool) -> Void = { isOn in }

    init(text: String = "", isFlexible: Bool = false, isOn: Binding<Bool>, onChange: @escaping (Bool) -> Void = { isOn in }) {
        self.text = text
        self.isOn = isOn
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
        Button {
            self.onChange(!self.isOn.wrappedValue)
            withAnimation(.easeInOut(duration: 0.1)) {
                self.isOn.wrappedValue.toggle()
            }
        } label: {
            Capsule()
                .fill(self.isOn.wrappedValue ? .green : .black.opacity(0.3))
                .frame(width: self.w, height: self.h)
                .overlay(alignment: self.isOn.wrappedValue ? .trailing : .leading) {
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

@available(macOS 14.0, *) #Preview {
    @Previewable @State var isOn: Bool = false
    HStack {
        CustomToggle(
            text: "Test",
            isOn: $isOn
        ).frame(width: 100, height: 50)
    }
    .padding(20)
}
