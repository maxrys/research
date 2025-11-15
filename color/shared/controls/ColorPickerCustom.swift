
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ColorPickerCustom: View {

    static let COLS = 20
    static let ROWS = 20
    static let CELL_SIZE = 15

    init() {
    }

    public var body: some View {

        let canvasW = Double(Self.CELL_SIZE * (Self.COLS + 1))
        let canvasH = Double(Self.CELL_SIZE * (Self.ROWS + 1))

        Canvas { context, size in
            for rowNum in 0 ... Self.ROWS {
            for colNum in 0 ... Self.COLS {
                let H: Decimal = Decimal(rowNum) / Decimal(Self.ROWS)
                let S: Decimal = 1.0
                let B: Decimal = Decimal(colNum) / Decimal(Self.COLS)
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * colNum),
                    y: Double(Self.CELL_SIZE * rowNum),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    colorFill: Color(
                        hue       : H.double,
                        saturation: S.double,
                        brightness: B.double
                    )
                )
            }}
            for rowNum in 0 ... Self.ROWS {
            for colNum in 0 ... Self.COLS {
                let H: Decimal =       Decimal(rowNum) / Decimal(Self.ROWS)
                let S: Decimal = 1.0 - Decimal(colNum) / Decimal(Self.COLS)
                let B: Decimal = 1.0
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * colNum) + canvasW,
                    y: Double(Self.CELL_SIZE * rowNum),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    colorFill: Color(
                        hue       : H.double,
                        saturation: S.double,
                        brightness: B.double
                    )
                )
            }}
        }
        .frame(
            width : canvasW * 2,
            height: canvasH
        )
        .pointerStyle(.link)
        .onTapGesture { location in
            let colNum: UInt = UInt(location.x / CGFloat(Self.CELL_SIZE))
            let rowNum: UInt = UInt(location.y / CGFloat(Self.CELL_SIZE))
            print("colNum: \(colNum) | rowNum: \(rowNum)")
        }
        .background(.red)

    }

}

#Preview {
    ColorPickerCustom()
        .frame(width: 200)
        .padding(10)
}
