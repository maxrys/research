
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let SIZE = 5
    static let COLS = 50
    static let ROWS = 50

    @State var saturation: Decimal = 0.5

    var body: some Scene {
        Window("Main", id: "main") {
            ScrollView(.vertical) {
                VStack {

                    HStack {
                        Button { if self.saturation > 0 {self.saturation -= 0.1} } label: { Text("-") }
                        Button { if self.saturation < 1 {self.saturation += 0.1} } label: { Text("+") }
                        Text(self.saturation.formatted(.number.precision(.fractionLength(2))))
                    }

                    Canvas { context, size in
                        for y in 0 ... Self.ROWS {
                        for x in 0 ... Self.COLS {
                            let hue        = Double(x) / Double(Self.COLS)
                            let brightness = Double(y) / Double(Self.ROWS)
                            context.drawRectangle(
                                x: Double(Self.SIZE * x),
                                y: Double(Self.SIZE * y),
                                w: Double(Self.SIZE),
                                h: Double(Self.SIZE),
                                colorFill: Color(
                                    hue       : hue,
                                    saturation: self.saturation.double,
                                    brightness: brightness
                                )
                            )
                            print("hue = \(hue) | brightness = \(brightness)")
                        };  print("y = \(y)") }
                    }
                    .frame(
                        width : Double(Self.SIZE * (Self.COLS + 1)),
                        height: Double(Self.SIZE * (Self.ROWS + 1))
                    )

                }.padding(10)

                /* ############# */
                /* ### MARK: Hex */
                /* ############# */

                HStack(spacing: 5) {

                    self.colorBox(hex: 0x000000)
                    self.colorBox(hex: 0x111111)
                    self.colorBox(hex: 0x222222)
                    self.colorBox(hex: 0x333333)
                    self.colorBox(hex: 0x444444)
                    self.colorBox(hex: 0x555555)
                    self.colorBox(hex: 0x666666)
                    self.colorBox(hex: 0x777777)
                    self.colorBox(hex: 0x888888)
                    self.colorBox(hex: 0x999999)
                    self.colorBox(hex: 0xAAAAAA)
                    self.colorBox(hex: 0xBBBBBB)
                    self.colorBox(hex: 0xCCCCCC)
                    self.colorBox(hex: 0xDDDDDD)
                    self.colorBox(hex: 0xEEEEEE)
                    self.colorBox(hex: 0xFFFFFF)
                    self.colorBox(hex: UInt.max)

                }.padding(10)

                /* ############### */
                /* ### MARK: shift */
                /* ############### */

                let columns: [GridItem] = (0 ... 20).map { _ in
                    GridItem(.fixed(20), spacing: 0)
                }

                VStack(spacing: 10) {

                    Text("hueShift")
                        .font(.headline)

                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(0 ... 360 + 1, id: \.self) { i in
                            let color = Color(fromUInt: 0x00_ff_00)
                            let newColorAmount = CGFloat(i)
                            let newColor = color.hueShift(amount: newColorAmount)
                            newColor.frame(width: 20, height: 20)
                        }
                    }

                }.padding(10)

                VStack(spacing: 10) {

                    Text("saturationShift")
                        .font(.headline)

                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(0 ... 100 + 1, id: \.self) { i in
                            let color = Color(fromUInt: 0x00_ff_00)
                            let newColorAmount = Decimal(i) * Decimal(0.01)
                            let newColor = color.saturationShift(amount: newColorAmount.double)
                            newColor.frame(width: 20, height: 20)
                        }
                    }

                }.padding(10)

                VStack(spacing: 10) {

                    Text("brightnessShift")
                        .font(.headline)

                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(0 ... 100 + 1, id: \.self) { i in
                            let color = Color(fromUInt: 0x00_ff_00)
                            let newColorAmount = Decimal(i) * Decimal(0.01)
                            let newColor = color.brightnessShift(amount: newColorAmount.double)
                            newColor.frame(width: 20, height: 20)
                        }
                    }

                }.padding(10)

            }.padding(20)
        }
    }

    @ViewBuilder func colorBox(hex: UInt) -> some View {
        Color(fromUInt: hex)
            .frame(width: 20, height: 20)
    }

    init() {

        print("\( Color.red.uint )")
        print("\( Color.orange.uint )")
        print("\( Color.yellow.uint )")
        print("\( Color.green.uint )")
        print("\( Color.blue.uint )")
        print("\( Color.black.uint )")
        print("\( Color.white.uint )")
        print("\( Color(fromUInt: UInt.max).uint )")

    }

}
