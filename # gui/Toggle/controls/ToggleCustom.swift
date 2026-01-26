
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ToggleCustom: View {

    @Binding private var isOn: Bool

    var width: CGFloat = 40
    var height: CGFloat = 16
    var innerPadding: CGFloat = 3

    private var text: String
    private var isFlexible: Bool
    private var onChange: (Bool) -> Void

    init(text: String = "", isFlexible: Bool = false, isOn: Binding<Bool>, onChange: @escaping (Bool) -> Void = { isOn in }) {
        self.text = text
        self._isOn = isOn
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
            self.onChange(!self.isOn)
            withAnimation(.easeInOut(duration: 0.1)) {
                self.isOn.toggle()
            }
        } label: {
            ZStack(alignment: self.isOn ? .trailing : .leading) {
                Capsule()
                    .fill(self.isOn ? .green : .black.opacity(0.3))
                    .frame(width: self.width, height: self.height)
                Capsule()
                    .fill(.white)
                    .frame(width: (self.height * 1.5) - (self.innerPadding * 2), height: self.height - (self.innerPadding * 2))
                    .padding(self.innerPadding)
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 2.0
                    )
            }.contentShapePolyfill(Capsule())
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

@available(macOS 14.0, *) #Preview {
    @Previewable @State var isOn: Bool = false
    HStack {
        ToggleCustom(
            text: "Test",
            isOn: $isOn
        ).frame(width: 100, height: 50)
    }
    .padding(20)
}
