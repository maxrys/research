
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ColorPickerOld: View {

    static let COLS = 40
    static let ROWS = 40
    static let CELL_SIZE = 8

    @Binding private var color: ColorHSBValue
    @State private var isShowPopover = false

    let openerSize: CGSize
    let openerRadius: CGFloat

    init(
        _ color: Binding<ColorHSBValue>,
        openerSize: CGSize = CGSize(width: 20, height: 20),
        openerRadius: CGFloat = 0
    ) {
        self._color = color
        self.openerSize = openerSize
        self.openerRadius = openerRadius
    }

    static private var canvasWithPalette: some View = {
        Canvas { context, size in
            for rowNum in 0 ... Self.ROWS     {
            for colNum in 0 ... Self.COLS * 2 {
                let cellColor = Self.cellColor(colNum, rowNum)
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * colNum),
                    y: Double(Self.CELL_SIZE * rowNum),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    colorFill: Color(
                        hue       : cellColor.hue,
                        saturation: cellColor.saturation,
                        brightness: cellColor.brightness
                    )
                )
            }}
        }
    }()

    static private func cellColor(_ colNum: Int, _ rowNum: Int) -> ColorHSBValue {
        let H =                            Decimal(rowNum            ) / Decimal(Self.ROWS)
        let S = colNum > Self.COLS ? 1.0 - Decimal(colNum - Self.COLS) / Decimal(Self.COLS) : 1.0
        let B = colNum > Self.COLS ? 1.0 : Decimal(colNum            ) / Decimal(Self.COLS)
        return ColorHSBValue(H.double, S.double, B.double, 1.0)
    }

    public var body: some View {
        Button {
            self.isShowPopover = true
        } label: {
            Color(
                hue       : self.color.hue,
                saturation: self.color.saturation,
                brightness: self.color.brightness,
                opacity   : self.color.opacity.fixBounds(min: 0.01, max: 1.0)
            )
            .frame(width: openerSize.width, height: openerSize.height)
            .overlay { self.zebraStroke }
            .clipShape(                 RoundedRectangle(cornerRadius: self.openerRadius))
            .contentShape(.focusEffect, RoundedRectangle(cornerRadius: self.openerRadius))
        }
        .buttonStyle(.plain)
        .pointerStyle(.link)
        .popover(isPresented: self.$isShowPopover) {
            self.popover
            self.opacityChanger
        }
    }

    @ViewBuilder private var zebraStroke: some View {
        ZStack {
            RoundedRectangle(cornerRadius: self.openerRadius)
                .stroke(.black, lineWidth: 1)
            RoundedRectangle(cornerRadius: self.openerRadius)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [1], dashPhase: 0.5))
                .foregroundStyle(.white)
        }
    }

    @ViewBuilder private var popover: some View {
        let canvasW = Double(Self.CELL_SIZE * (Self.COLS + 1))
        let canvasH = Double(Self.CELL_SIZE * (Self.ROWS + 1))
        ZStack {

            Self.canvasWithPalette
                .opacity(self.color.opacity)

            /* selection visualizer */

            Canvas { context, size in
                for rowNum in 0 ... Self.ROWS     {
                for colNum in 0 ... Self.COLS * 2 {
                    let cellColor = Self.cellColor(colNum, rowNum)
                    if (self.color.hue        == cellColor.hue        &&
                        self.color.saturation == cellColor.saturation &&
                        self.color.brightness == cellColor.brightness) {
                        context.drawRectangle(
                            x: Double(Self.CELL_SIZE * colNum),
                            y: Double(Self.CELL_SIZE * rowNum),
                            w: Double(Self.CELL_SIZE),
                            h: Double(Self.CELL_SIZE),
                            lineWidth: 1,
                            colorLine: colNum < Self.COLS ? .white : .black,
                            colorFill: .clear
                        )
                        return
                    }
                }}
            }

        }
        .frame(
            width : canvasW * 2 - Double(Self.CELL_SIZE),
            height: canvasH
        )
        .pointerStyle(.link)
        .onTapGesture { location in
            let colNum = Int(location.x / CGFloat(Self.CELL_SIZE))
            let rowNum = Int(location.y / CGFloat(Self.CELL_SIZE))
            let currentOpacity = self.color.opacity
            self.color = Self.cellColor(colNum, rowNum)
            self.color.opacity = currentOpacity
        }
    }

    @ViewBuilder private var opacityChanger: some View {
        VStack(spacing: 10) {
            Slider(
                value: Binding<Double>(
                    get: {          self.color.opacity },
                    set: { value in self.color.opacity = value }
                ),
                in: 0.0 ... 1.0,
                step: 0.01
            )
            let formattedValue = self.color.opacity.formatted(
                .number.precision(
                    .fractionLength(2)
                )
            )
            Text("Opacity: \(formattedValue)")
                .font(.headline)
        }
        .padding(.horizontal, 20)
        .padding(.vertical  , 10)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    @Previewable @State var pickerColor = ColorHSBValue(0.0, 1.0, 0.0)
    ColorPickerOld(
        $pickerColor, openerRadius: 5
    ).onChange(of: pickerColor) { oldValue, newValue in
        print(newValue.encode() ?? "")
    }.padding(10)
}
