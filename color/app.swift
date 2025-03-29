
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    @State var saturation: Double = 0.65

    let SIZE = 5

    var cols = 100
    var rows = 100

    var body: some Scene {
        WindowGroup {
            VStack {

                HStack {
                    Button { if self.saturation > 0 {self.saturation -= 0.01} } label: { Text("-") }
                    Text("\(self.saturation)")
                    Button { if self.saturation < 1 {self.saturation += 0.01} } label: { Text("+") }
                }

                Canvas { context, size in
                    for y in 0 ... self.rows {
                    for x in 0 ... self.cols {
                        let hue        = Double(x) / Double(self.cols)
                        let brightness = Double(y) / Double(self.rows)
                        context.drawRectangle(
                            x: Double(self.SIZE * x),
                            y: Double(self.SIZE * y),
                            w: Double(self.SIZE),
                            h: Double(self.SIZE),
                            colorFill: Color(
                                hue       : hue, saturation: self.saturation,
                                brightness: brightness
                            )
                        )
                        print("hue = \(hue) | brightness = \(brightness)")
                    };  print("y = \(y)") }
                }
                .frame(
                    width : Double(self.SIZE * (self.cols + 1)),
                    height: Double(self.SIZE * (self.rows + 1))
                )

                Canvas { context, size in
                    context.drawRectangle(
                        w: 50,
                        h: 50,
                        colorFill: Color(
                            hue       : 0.56, saturation: 0.59,
                            brightness: 0.67
                        )
                    )
                }
                .frame(
                    width : 50,
                    height: 50
                )

            }.padding(10)
        }
    }

    init() {
    }

}
