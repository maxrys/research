
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension ColorPickerCustom {

    struct ColorHSB: Equatable, Codable {

        let H: Double
        let S: Double
        let B: Double

        init(_ H: Double, _ S: Double, _ B: Double) {
            self.H = H
            self.S = S
            self.B = B
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.H == rhs.H &&
            lhs.S == rhs.S &&
            lhs.B == rhs.B
        }

        init?(json: String) {
            do {
                guard let data = json.data(using: .utf8) else {
                    return nil
                }
                self = try JSONDecoder().decode(
                    Self.self,
                    from: data
                )
            } catch {
                return nil
            }
        }

        func toJSON() -> String? {
            guard let data = try? JSONEncoder().encode(self) else {
                return nil
            }
            return String(
                data: data,
                encoding: .utf8
            )
        }

    }

}

struct ColorPickerCustom: View {

    static let COLS = 40
    static let ROWS = 40
    static let CELL_SIZE = 8

    @State private var isShowPalette: Bool = false

    var color: Binding<ColorHSB>

    init(color: Binding<ColorHSB>) {
        self.color = color
    }

    private func getCellColor(_ colNum: Int, _ rowNum: Int) -> ColorHSB {
        let H =                            Decimal(rowNum            ) / Decimal(Self.ROWS)
        let S = colNum > Self.COLS ? 1.0 - Decimal(colNum - Self.COLS) / Decimal(Self.COLS) : 1.0
        let B = colNum > Self.COLS ? 1.0 : Decimal(colNum            ) / Decimal(Self.COLS)
        return ColorHSB(H.double, S.double, B.double)
    }

    public var body: some View {
        Button {
            self.isShowPalette = true
        } label: {
            Color(
                hue       : self.color.wrappedValue.H,
                saturation: self.color.wrappedValue.S,
                brightness: self.color.wrappedValue.B
            ).frame(width: 20, height: 20)
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
                let cellColor = self.getCellColor(colNum, rowNum)
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * colNum),
                    y: Double(Self.CELL_SIZE * rowNum),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    lineWidth: self.color.wrappedValue == cellColor ? 3 : 0,
                    colorLine: self.color.wrappedValue == cellColor ? (colNum < Self.COLS ? .white : .black) : .clear,
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
            self.color.wrappedValue = self.getCellColor(colNum, rowNum)
            self.isShowPalette = false
        }

    }

}

#Preview {
    @Previewable @State var pickerColor = ColorPickerCustom.ColorHSB(0.0, 1.0, 0.0)
    ColorPickerCustom(
        color: $pickerColor
    )
    .frame(width: 200)
    .padding(10)
}
