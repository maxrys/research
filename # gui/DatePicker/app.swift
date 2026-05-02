
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var date = Date()

    public var body: some Scene {
        WindowGroup {
            DatePickerCustom(
                value: self.$date
            ).padding(20)
        }
    }

}
