
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension ColorPickerCustom {

    struct ColorHSB: Equatable, Codable {

        let hue: Double
        let saturation: Double
        let brightness: Double
        let opacity: Double

        init(_ hue: Double, _ saturation: Double, _ brightness: Double, _ opacity: Double = 1.0) {
            self.hue = hue
            self.saturation = saturation
            self.brightness = brightness
            self.opacity = opacity
        }

        init?(decode json: String) {
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

        func encode() -> String? {
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
    @State private var opacity: Double = 1.0

    var color: Binding<ColorHSB>

    init(color: Binding<ColorHSB>) {
        self.color = color
    }

    private func cellColor(_ colNum: Int, _ rowNum: Int) -> ColorHSB {
        let H =                            Decimal(rowNum            ) / Decimal(Self.ROWS)
        let S = colNum > Self.COLS ? 1.0 - Decimal(colNum - Self.COLS) / Decimal(Self.COLS) : 1.0
        let B = colNum > Self.COLS ? 1.0 : Decimal(colNum            ) / Decimal(Self.COLS)
        return ColorHSB(H.double, S.double, B.double, 1.0)
    }

    public var body: some View {
        Button {
            self.isShowPalette = true
        } label: {
            Color(
                hue       : self.color.wrappedValue.hue,
                saturation: self.color.wrappedValue.saturation,
                brightness: self.color.wrappedValue.brightness,
                opacity   : self.color.wrappedValue.opacity
            ).frame(width: 20, height: 20)
        }
        .buttonStyle(.plain)
        .pointerStyle(.link)
        .popover(isPresented: self.$isShowPalette) {
            self.palette
            self.opacityChanger
            self.resultColor
        }
    }

    @ViewBuilder private var palette: some View {

        let canvasW = Double(Self.CELL_SIZE * (Self.COLS + 1))
        let canvasH = Double(Self.CELL_SIZE * (Self.ROWS + 1))

        Canvas { context, size in
            for rowNum in 0 ... Self.ROWS     {
            for colNum in 0 ... Self.COLS * 2 {
                let cellColor = self.cellColor(colNum, rowNum)
                context.drawRectangle(
                    x: Double(Self.CELL_SIZE * colNum),
                    y: Double(Self.CELL_SIZE * rowNum),
                    w: Double(Self.CELL_SIZE),
                    h: Double(Self.CELL_SIZE),
                    lineWidth: self.color.wrappedValue == cellColor ? 3 : 0,
                    colorLine: self.color.wrappedValue == cellColor ? (colNum < Self.COLS ? .white : .black) : .clear,
                    colorFill: Color(
                        hue       : cellColor.hue,
                        saturation: cellColor.saturation,
                        brightness: cellColor.brightness
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
            let cellColor = self.cellColor(colNum, rowNum)
            self.color.wrappedValue = ColorHSB(
                cellColor.hue,
                cellColor.saturation,
                cellColor.brightness,
                self.opacity
            )
            self.isShowPalette = false
        }

    }

    @ViewBuilder private var opacityChanger: some View {
        VStack(spacing: 10) {
            Slider(value: self.$opacity, in: 0.0 ... 1.0)
            Text("Opacity: \(self.opacity, specifier: "%.2f")")
                .font(.headline)
        }
        .padding(.horizontal, 20)
        .padding(.vertical  , 10)
    }

    @ViewBuilder private var resultColor: some View {
        Color(
            hue       : self.color.wrappedValue.hue,
            saturation: self.color.wrappedValue.saturation,
            brightness: self.color.wrappedValue.brightness,
            opacity   : self.opacity
        )
        .frame(width: 100, height: 50)
        .padding(20)
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
