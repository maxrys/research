/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ColorPickerHSB: View {

    @Binding private var color: ColorHSBValue
    @State private var isShowPalette: Bool = false

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
            self.huePalette
        }
    }

    @ViewBuilder var popover: some View {
        VStack(spacing: 10) {
            self.huePalette       .frame(height: 30)
            self.saturationPalette.frame(height: 30)
            self.brightnessPalette.frame(height: 30)
        }.frame(width: 200)
    }

    @ViewBuilder private var huePalette: some View {
        Canvas { context, size in
            for i in 0 ... Int(size.width) {
                context.drawRectangle(
                    x: CGFloat(i),
                    y: 0,
                    w: 1,
                    h: size.height,
                    colorFill: Color(
                        hue       : 1.0 / size.width * CGFloat(i),
                        saturation: 1.0,
                        brightness: 1.0
                    )
                )
            }
        }
    }

    @ViewBuilder private var saturationPalette: some View {
        Canvas { context, size in
            for i in 0 ... Int(size.width) {
                context.drawRectangle(
                    x: CGFloat(i),
                    y: 0,
                    w: 1,
                    h: size.height,
                    colorFill: Color(
                        hue       : self.color.hue,
                        saturation: 1.0 / size.width * CGFloat(i),
                        brightness: 1.0
                    )
                )
            }
        }
    }

    @ViewBuilder private var brightnessPalette: some View {
        Canvas { context, size in
            for i in 0 ... Int(size.width) {
                context.drawRectangle(
                    x: CGFloat(i),
                    y: 0,
                    w: 1,
                    h: size.height,
                    colorFill: Color(
                        hue       : self.color.hue,
                        saturation: 1.0,
                        brightness: 1.0 / size.width * CGFloat(i)
                    )
                )
            }
        }
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
    @Previewable @State var pickerColor = ColorHSBValue(0.0, 1.0, 0.0)
    ColorPickerHSB(color: $pickerColor)
        .popover
        .padding(20)
}
