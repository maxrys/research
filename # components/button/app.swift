
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    var body: some Scene {
        WindowGroup {
            VStack {
                CustomButton(text: "test")
                CustomButton(text: "test", zoom: 1.5)
                CustomButton(text: "test", zoom: 2.0)
                CustomButton(text: "test", zoom: 2.5)
                CustomButton(text: "test", zoom: 3.0)
            }.padding(10)
        }
    }

    init() {
    }

}
