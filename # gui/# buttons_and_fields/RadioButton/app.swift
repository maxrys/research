
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public var body: some Scene {
        WindowGroup {
            HStack {
                RadioButton_UInt()
                RadioButton_Enum()
                RadioButton_Simple()
            }
        }
    }

}
