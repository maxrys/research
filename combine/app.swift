
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    @State var time: String = "00:00:00"

    var body: some Scene {
        WindowGroup {
            VStack {
                Text("\(time)")
            }
        }
    }

    init() {
        test_timer()
    }

}
