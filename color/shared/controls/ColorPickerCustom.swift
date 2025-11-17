
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ColorPickerCustom: View {

    static let COLS = 10
    static let ROWS = 10
    static let CELL_SIZE = 30

    init() {
    }

    func getColor(_ colNum: Int, _ rowNum: Int) -> (H: Decimal, S: Decimal, B: Decimal) {(
        H:                            Decimal(rowNum            ) / Decimal(Self.ROWS),
        S: colNum > Self.COLS ? 1.0 - Decimal(colNum - Self.COLS) / Decimal(Self.COLS) : 1.0,
        B: colNum > Self.COLS ? 1.0 : Decimal(colNum            ) / Decimal(Self.COLS)
    )}

    public var body: some View {

        let canvasW = Double(Self.CELL_SIZE * (Self.COLS + 1))
        let canvasH = Double(Self.CELL_SIZE * (Self.ROWS + 1))

        Canvas { context, size in
            for rowNum in 0 ... Self.ROWS     {
            for colNum in 0 ... Self.COLS * 2 {
                let color = self.getColor(colNum, rowNum)
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * colNum),
                    y: Double(Self.CELL_SIZE * rowNum),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    colorFill: Color(
                        hue       : color.H.double,
                        saturation: color.S.double,
                        brightness: color.B.double
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
            let color = self.getColor(colNum, rowNum)
            print("colNum: \(colNum) | rowNum: \(rowNum) | H: \(color.H) | S: \(color.S) | B: \(color.B)")
        }

    }

}

#Preview {
    ColorPickerCustom()
        .frame(width: 200)
        .padding(10)
}
