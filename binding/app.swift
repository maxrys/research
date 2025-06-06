
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    var body: some Scene {
        WindowGroup {
            VStack(spacing: 10) {
                DemoProxyView()
                DemoOptionalView()
            }
        }
    }

    init() {
    }

}
