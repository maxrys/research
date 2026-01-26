
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {
            VStack {
                Text("Property list")
            }
        }
    }

    init() {

        dump(
            ModelDemo.select()
        )

    }

}
