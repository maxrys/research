
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public var body: some Scene {
        WindowGroup {
            DatePickerCustom(
                value: .constant(Date())
            ).padding(20)
        }
    }

}
