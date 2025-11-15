
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ColorPickerCustom: View {

    static let COLS = 50
    static let ROWS = 50
    static let CELL_SIZE = 5

    @State var saturation: Decimal = 0.5
    @State var brightness: Decimal = 0.5

    init() {
    }

    public var body: some View {

        Canvas { context, size in
            for y in 0 ... Self.ROWS {
            for x in 0 ... Self.COLS {
                let hue        = Double(x) / Double(Self.COLS)
                let brightness = Double(y) / Double(Self.ROWS)
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * x),
                    y: Double(Self.CELL_SIZE * y),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    colorFill: Color(
                        hue       : hue,
                        saturation: self.saturation.double,
                        brightness: self.brightness.double
                    )
                )
                print(
                    "H: \(self.formatDouble(hue)) | " +
                    "S: \(self.formatDouble(brightness)) | " +
                    "B: \(self.formatDouble(self.saturation.double))"
                )
            }}
        }
        .frame(
            width : Double(Self.CELL_SIZE * (Self.COLS + 1)),
            height: Double(Self.CELL_SIZE * (Self.ROWS + 1))
        )

        HStack(spacing: 10) {
            Text("saturation").font(.headline)
                Button { if self.saturation > 0 {self.saturation -= 0.1} } label: { Text("-") }
                Button { if self.saturation < 1 {self.saturation += 0.1} } label: { Text("+") }
            Text(self.formatDouble(self.saturation.double))
        }

        HStack {
            Text("brightness").font(.headline)
                Button { if self.brightness > 0 {self.brightness -= 0.1} } label: { Text("-") }
                Button { if self.brightness < 1 {self.brightness += 0.1} } label: { Text("+") }
            Text(self.formatDouble(self.brightness.double))
        }

    }

    func formatDouble(_ value: Double, fractionLength: Int = 3) -> String {
        value.formatted(
            .number.precision(
                .fractionLength(fractionLength)
            )
        )
    }

}

#Preview {
    ColorPickerCustom()
        .frame(width: 200)
        .padding(10)
}
