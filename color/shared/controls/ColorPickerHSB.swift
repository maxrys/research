
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

    @Binding private var color: ColorHSBValue
    @State private var isShowPopover: Bool = false

    let width: CGFloat = 200
    let openerSize: CGSize
    let openerRadius: CGFloat

    private var colorView: Color {
        Color(
            hue       : self.color.hue,
            saturation: self.color.saturation,
            brightness: self.color.brightness,
            opacity   : self.color.opacity
        )
    }

    init(
        color: Binding<ColorHSBValue>,
        openerSize: CGSize = CGSize(width: 20, height: 20),
        openerRadius: CGFloat = 0
    ) {
        self._color = color
        self.openerSize = openerSize
        self.openerRadius = openerRadius
    }

    public var body: some View {
        Button {
            self.isShowPopover = true
        } label: {
            self.colorView
                .frame(
                    width : openerSize.width,
                    height: openerSize.height
                )
                .overlay {
                    RoundedRectangle(cornerRadius: self.openerRadius)
                        .stroke(.black, lineWidth: 1)
                    RoundedRectangle(cornerRadius: self.openerRadius)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [1], dashPhase: 0.5))
                        .foregroundStyle(.white)
                }
                .clipShape(                 RoundedRectangle(cornerRadius: self.openerRadius))
                .contentShape(.focusEffect, RoundedRectangle(cornerRadius: self.openerRadius))
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
                self.chessboard
                self.colorView
                self.indicator(component: .O)
                self.touchpad (component: .O)
            }.frame(height: 30)

        }
        .frame(width: self.width)
        .padding(20)
    }

    @ViewBuilder private var chessboard: some View {
        let cellSize: CGFloat = 10
        Canvas { context, size in
            context.drawRectangle(x: 0, y: 0, w: size.width, h: size.height, colorFill: .white)
            for j in 0 ... Int(size.height / cellSize) {
            for i in 0 ... Int(size.width  / cellSize) {
                if (i % 2 == 0 && j % 2 != 0) ||
                   (i % 2 != 0 && j % 2 == 0) {
                    context.drawRectangle(
                        x: CGFloat(i) * cellSize,
                        y: CGFloat(j) * cellSize,
                        w: cellSize,
                        h: cellSize,
                        colorFill: .black.opacity(0.3)
                    )
                }
            }}
        }
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
                .stroke(.white, lineWidth: 3)
                .frame(width: 12)
                .shadow(
                    color: .black.opacity(0.7),
                    radius: 2.0
                )
            Text({
                switch component {
                    case .H: "H"
                    case .S: "S"
                    case .B: "B"
                    case .O: "O" }}())
            .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundStyle(.white)
                .shadow(
                    color: .black,
                    radius: 1.0
                )
        }
        .padding(.horizontal, -6)
        .padding(.vertical  , -1)
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
