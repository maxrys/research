/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ColorPickerHSB: View {

    enum ColorComponent {
        case H
        case S
        case B
        case O
    }

    @Environment(\.colorScheme) private var colorScheme
    @Binding private var color: ColorHSBValue
    @State private var isShowPopover: Bool = false

    let width: CGFloat = 200
    private var colorView: some View {
        Color(
            hue       : self.color.hue,
            saturation: self.color.saturation,
            brightness: self.color.brightness,
            opacity   : self.color.opacity
        )
    }

    init(color: Binding<ColorHSBValue>) {
        self._color = color
    }

    public var body: some View {
        Button {
            self.isShowPopover = true
        } label: {
            self.colorView.frame(width: 20, height: 20)
        }
        .buttonStyle(.plain)
        .pointerStyle(.link)
        .popover(isPresented: self.$isShowPopover) {
            self.popover
        }
    }

    @ViewBuilder var popover: some View {
        VStack(spacing: 20) {

            ZStack(alignment: .leading) {
                self.palette  (component: .H)
                self.indicator(component: .H)
                self.touchpad (component: .H)
            }.frame(height: 30)

            ZStack(alignment: .leading) {
                self.palette  (component: .S)
                self.indicator(component: .S)
                self.touchpad (component: .S)
            }.frame(height: 30)

            ZStack(alignment: .leading) {
                self.palette  (component: .B)
                self.indicator(component: .B)
                self.touchpad (component: .B)
            }.frame(height: 30)

            ZStack(alignment: .leading) {
                self.colorView
                self.indicator(component: .O)
                self.touchpad (component: .O)
            }.frame(height: 30)

        }
        .frame(width: self.width)
        .padding(20)
    }

    @ViewBuilder private func palette(component: ColorComponent) -> some View {
        Canvas { context, size in
            for i in 0 ... Int(size.width) {
                context.drawRectangle(
                    x: CGFloat(i),
                    y: 0,
                    w: 1,
                    h: size.height,
                    colorFill: Color(
                        hue       : component == .H ? 1.0 / size.width * CGFloat(i) : self.color.hue,
                        saturation: component == .S ? 1.0 / size.width * CGFloat(i) : 1.0,
                        brightness: component == .B ? 1.0 / size.width * CGFloat(i) : 1.0
                    )
                )
            }
        }
    }

    @ViewBuilder private func indicator(component: ColorComponent) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .stroke(.white, lineWidth: 4)
                .frame(width: 12)
            Text({
                switch component {
                    case .H: "H"
                    case .S: "S"
                    case .B: "B"
                    case .O: "O" }}())
                .font(.system(size: 10, design: .monospaced))
                .foregroundStyle(.white)
        }
        .shadow(
            color: self.colorScheme == .dark ?
                .white.opacity(0.5) :
                .black.opacity(0.5),
            radius: 1.0
        )
        .padding(.horizontal, -6)
        .padding(.vertical  , -2)
        .offset(x: {
            switch component {
                case .H: self.width * self.color.hue
                case .S: self.width * self.color.saturation
                case .B: self.width * self.color.brightness
                case .O: self.width * self.color.opacity
            }
        }())
    }

    @ViewBuilder private func touchpad(component: ColorComponent) -> some View {
        let setComponentValue: (ColorComponent, Double) -> Void = { component, value in
            switch component {
                case .H: self.color.hue        = value
                case .S: self.color.saturation = value
                case .B: self.color.brightness = value
                case .O: self.color.opacity    = value
            }
        }
        Rectangle()
            .foregroundColor(.clear)
            .contentShape(Rectangle())
            .pointerStyle(.link)
            .onTapGesture { location in
                let x = location.x.fixBounds(max: self.width)
                setComponentValue(component, x / self.width)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let x = gesture.location.x.fixBounds(max: self.width)
                        setComponentValue(component, x / self.width)
                    }
            )
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    @Previewable @State var pickerColor = ColorHSBValue(0.0, 1.0, 0.0)
    ColorPickerHSB(color: $pickerColor)
        .padding(20)
        .onChange(of: pickerColor) { _, value in
            print(value.encode() ?? "")
        }
}

#Preview {
    @Previewable @State var pickerColorR = ColorHSBValue(0.00, 1.0, 0.0)
    @Previewable @State var pickerColorG = ColorHSBValue(0.33, 1.0, 0.0)
    @Previewable @State var pickerColorB = ColorHSBValue(0.66, 1.0, 0.0)
    ColorPickerHSB(color: $pickerColorR).popover
    ColorPickerHSB(color: $pickerColorG).popover
    ColorPickerHSB(color: $pickerColorB).popover
}
