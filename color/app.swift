
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let SIZE = 5
    static let COLS = 50
    static let ROWS = 50

    @State var saturation: Decimal = 0.5
    @State var brightness: Decimal = 0.5

    init() {
    }

    func formatDouble(_ value: Double, fractionLength: Int = 3) -> String {
        value.formatted(
            .number.precision(
                .fractionLength(fractionLength)
            )
        )
    }

    @ViewBuilder func colorBox(hex: UInt) -> some View {
        Color(fromUInt: hex)
            .frame(width: 20, height: 20)
    }

    var body: some Scene {
        Window("Main", id: "main") {
            ScrollView(.vertical) {
                VStack {

                    HStack {
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

                /* ############## */
                /* ### MARK: tune */
                /* ############## */

                Text("Tune")
                    .font(.headline)

                HStack(spacing: 1) {
                    Color.red.tune(brightness: -0.1).frame(width: 20, height: 20)
                    Color.red.tune(brightness: -0.2).frame(width: 20, height: 20)
                    Color.red.tune(brightness: -0.3).frame(width: 20, height: 20)
                    Color.red.tune(brightness: -0.4).frame(width: 20, height: 20)
                    Color.red.tune(brightness: -0.5).frame(width: 20, height: 20)
                    Color.red.tune(brightness: -0.6).frame(width: 20, height: 20)
                }

                HStack(spacing: 1) {
                    Color.red.tune(saturation: -0.1).frame(width: 20, height: 20)
                    Color.red.tune(saturation: -0.2).frame(width: 20, height: 20)
                    Color.red.tune(saturation: -0.3).frame(width: 20, height: 20)
                    Color.red.tune(saturation: -0.4).frame(width: 20, height: 20)
                    Color.red.tune(saturation: -0.5).frame(width: 20, height: 20)
                    Color.red.tune(saturation: -0.6).frame(width: 20, height: 20)
                }

                HStack(spacing: 1) {
                    Color(red: 255, green: 0, blue: 0).tune(brightness: -0.1).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(brightness: -0.2).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(brightness: -0.3).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(brightness: -0.4).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(brightness: -0.5).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(brightness: -0.6).frame(width: 20, height: 20)
                }

                HStack(spacing: 1) {
                    Color(red: 255, green: 0, blue: 0).tune(saturation: -0.1).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(saturation: -0.2).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(saturation: -0.3).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(saturation: -0.4).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(saturation: -0.5).frame(width: 20, height: 20)
                    Color(red: 255, green: 0, blue: 0).tune(saturation: -0.6).frame(width: 20, height: 20)
                }

                /* ############### */
                /* ### MARK: shift */
                /* ############### */

                let columns: [GridItem] = (0 ... 20).map { _ in
                    GridItem(.fixed(20), spacing: 1)
                }

                VStack(spacing: 10) {

                    Text("RGBtoHSB")
                        .font(.headline)

                    LazyVGrid(columns: columns, spacing: 1) {
                        let color = Color(fromUInt: 0x00_00_FF)
                        let (red, green, blue) = color.RGB
                        let (hue, saturation, _) = Color.RGBtoHSB(red, green, blue)
                        ForEach(0 ... 100, id: \.self) { i in
                            Color(hue: hue / 360, saturation: saturation, brightness: Double(i) * 0.01)
                                .frame(width: 20, height: 20)
                        }
                    }

                    Text("brightnessSet")
                        .font(.headline)

                    LazyVGrid(columns: columns, spacing: 1) {
                        let color = Color(fromUInt: 0x00_00_FF)
                        ForEach(0 ... 100, id: \.self) { i in
                            color.brightnessSet(Double(i) * 0.01)
                                .frame(width: 20, height: 20)
                        }
                    }

                    Text("brightnessShift")
                        .font(.headline)

                    LazyVGrid(columns: columns, spacing: 1) {
                        let color = Color(fromUInt: 0x00_00_FF)
                        ForEach((0 ... 100).reversed(), id: \.self) { i in
                            color.brightnessShift(-(Double(i) * 0.01))
                                .frame(width: 20, height: 20)
                        }
                    }

                }.padding(10)

            }.padding(20)
        }
    }

}
