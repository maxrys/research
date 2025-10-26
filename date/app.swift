
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {

            let formattedDate = Date().formatCustom("yyyyMMdd-HHmmss")
            Text("\(formattedDate)")

        }
    }

    init() {
    }

}
