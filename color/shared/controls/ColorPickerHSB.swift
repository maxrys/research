/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ColorPickerHSB: View {

    enum ColorComponent {
        case H
        case S
        case B
    }

    @Binding private var color: ColorHSBValue
    @State private var isShowPalette: Bool = false

    let width: CGFloat = 200

    init(color: Binding<ColorHSBValue>) {
        self._color = color
    }

    public var body: some View {
        Button {
            self.isShowPalette = true
        } label: {
            Color(
                hue       : self.color.hue,
                saturation: self.color.saturation,
                brightness: self.color.brightness,
                opacity   : self.color.opacity
            ).frame(width: 20, height: 20)
        }
        .buttonStyle(.plain)
        .pointerStyle(.link)
        .popover(isPresented: self.$isShowPalette) {
            self.popover
        }
    }

    @ViewBuilder var popover: some View {
        VStack(spacing: 10) {

            ZStack(alignment: .leading) {
                self.palette(component: .H)
                self.knob   (component: .H)
            }.frame(height: 30)

            ZStack(alignment: .leading) {
                self.palette(component: .S)
                self.knob   (component: .S)
            }.frame(height: 30)

            ZStack(alignment: .leading) {
                self.palette(component: .B)
                self.knob   (component: .B)
            }.frame(height: 30)

        }
        .frame(width: self.width)
        .padding(20)
    }

    @ViewBuilder private func knob(component: ColorComponent) -> some View {
        RoundedRectangle(cornerRadius: 2)
            .stroke(.black.opacity(0.5), lineWidth: 3)
            .fill(.white.opacity(0.01))
            .frame(width: 10)
            .padding(-5)
            .offset(x: {
                switch component {
                    case .H: width * self.color.hue
                    case .S: width * self.color.saturation
                    case .B: width * self.color.brightness
                }
            }())
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
        .pointerStyle(.link)
        .onTapGesture { location in
            let x = location.x.fixBounds(max: self.width)
            switch component {
                case .H: self.color.hue        = x / width
                case .S: self.color.saturation = x / width
                case .B: self.color.brightness = x / width
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    let x = gesture.location.x.fixBounds(max: self.width)
                    switch component {
                        case .H: self.color.hue        = x / width
                        case .S: self.color.saturation = x / width
                        case .B: self.color.brightness = x / width
                    }
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
    ColorPickerHSB(color: $pickerColorR).popover.padding(20)
    ColorPickerHSB(color: $pickerColorG).popover.padding(20)
    ColorPickerHSB(color: $pickerColorB).popover.padding(20)
}
