
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ColorPickerCustom: View {

    typealias ColorHSB = (H: Double, S: Double, B: Double)

    static let COLS = 40
    static let ROWS = 40
    static let CELL_SIZE = 8

    @State var color: ColorHSB = (H: 0.0, S: 1.0, B: 0.0)
    @State private var isShowPalette: Bool = false

    init() {
    }

    func getColor(_ colNum: Int, _ rowNum: Int) -> ColorHSB {
        let H =                            Decimal(rowNum            ) / Decimal(Self.ROWS)
        let S = colNum > Self.COLS ? 1.0 - Decimal(colNum - Self.COLS) / Decimal(Self.COLS) : 1.0
        let B = colNum > Self.COLS ? 1.0 : Decimal(colNum            ) / Decimal(Self.COLS)
        return (H.double, S.double, B.double)
    }

    public var body: some View {
        Button {
            self.isShowPalette = true
        } label: {
            Color(hue: self.color.H, saturation: self.color.S, brightness: self.color.B)
                .frame(width: 20, height: 20)
        }
        .buttonStyle(.plain)
        .pointerStyle(.link)
        .popover(isPresented: self.$isShowPalette) {
            self.palette
        }
    }

    @ViewBuilder private var palette: some View {

        let canvasW = Double(Self.CELL_SIZE * (Self.COLS + 1))
        let canvasH = Double(Self.CELL_SIZE * (Self.ROWS + 1))

        Canvas { context, size in
            for rowNum in 0 ... Self.ROWS     {
            for colNum in 0 ... Self.COLS * 2 {
                let cellColor = self.getColor(colNum, rowNum)
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * colNum),
                    y: Double(Self.CELL_SIZE * rowNum),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    lineWidth: self.color == cellColor ? 3 : 0,
                    colorLine: self.color == cellColor ? (colNum < Self.COLS ? .white : .black) : .clear,
                    colorFill: Color(
                        hue       : cellColor.H,
                        saturation: cellColor.S,
                        brightness: cellColor.B
                    )
                )
            }}
        }
        .frame(
            width : canvasW * 2 - Double(Self.CELL_SIZE),
            height: canvasH
        )
        .pointerStyle(.link)
        .onTapGesture { location in
            let colNum = Int(location.x / CGFloat(Self.CELL_SIZE))
            let rowNum = Int(location.y / CGFloat(Self.CELL_SIZE))
            self.color = self.getColor(colNum, rowNum)
            self.isShowPalette = false
            print("H: \(self.color.H) | S: \(self.color.S) | B: \(self.color.B)")
        }

    }

}

#Preview {
    ColorPickerCustom()
        .frame(width: 200)
        .padding(10)
}
