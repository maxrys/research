
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import Combine

@main struct app: App {

    var body: some Scene {
        WindowGroup {
            TimerPublisher()
        }
    }

    init() {
    }

}
