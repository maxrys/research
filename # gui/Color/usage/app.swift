
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public var body: some Scene {
        Window("Main", id: "main") {
            VStack {
                ClassicDemo()
                ProtocolDemo()
            }.frame(width: 200)
        }
    }

}
