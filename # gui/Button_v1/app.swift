
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {
            VStack {
                ButtonCustom(text: "test")
                ButtonCustom(text: "test", zoom: 1.5)
                ButtonCustom(text: "test", zoom: 2.0)
                ButtonCustom(text: "test", zoom: 2.5)
                ButtonCustom(text: "test", zoom: 3.0)
            }.padding(10)
        }
    }

    init() {
    }

}
