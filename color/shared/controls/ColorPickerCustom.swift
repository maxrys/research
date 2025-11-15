
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ColorPickerCustom: View {

    static let COLS = 50
    static let ROWS = 50
    static let CELL_SIZE = 5

    init() {
    }

    public var body: some View {

        Canvas { context, size in
            for y in 0 ... Self.ROWS {
            for x in 0 ... Self.COLS {
                let H: Decimal = Decimal(y) / Decimal(Self.COLS)
                let S: Decimal = 1.0
                let B: Decimal = Decimal(x) / Decimal(Self.ROWS)
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * x),
                    y: Double(Self.CELL_SIZE * y),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    colorFill: Color(
                        hue       : H.double,
                        saturation: S.double,
                        brightness: B.double
                    )
                )
            }}
            for y in 0 ... Self.ROWS {
            for x in 0 ... Self.COLS {
                let H: Decimal = Decimal(y) / Decimal(Self.COLS)
                let S: Decimal = Decimal(x) / Decimal(Self.ROWS)
                let B: Decimal = 1.0
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * x) + Double(Self.CELL_SIZE * (Self.COLS + 1)),
                    y: Double(Self.CELL_SIZE * y),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    colorFill: Color(
                        hue       :     H.double,
                        saturation: 1 - S.double,
                        brightness:     B.double
                    )
                )
            }}
        }
        .frame(
            width : Double(Self.CELL_SIZE * (Self.COLS + 1)) * 2,
            height: Double(Self.CELL_SIZE * (Self.ROWS + 1))
        )

    }

}

#Preview {
    ColorPickerCustom()
        .frame(width: 200)
        .padding(10)
}
