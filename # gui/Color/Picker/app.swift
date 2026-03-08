
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State var colorValue = ColorHSBValue(
        0.0, 1.0, 0.0
    )

    var body: some Scene {
        Window("Main", id: "main") {
            HStack {

                ColorPickerHSBO(
                    self.$colorValue
                ).onChange(of: self.colorValue) { _, value in
                    print(value.encode() ?? "")
                }.padding(20)

                ColorPickerPalette(
                    self.$colorValue
                ).onChange(of: self.colorValue) { _, value in
                    print(value.encode() ?? "")
                }.padding(20)

            }.frame(width: 100, height: 100)
        }
    }

}
