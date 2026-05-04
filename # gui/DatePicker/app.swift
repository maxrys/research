
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var date = Date()

    public var body: some Scene {
        WindowGroup {
            VStack(spacing: 10) {

                DatePickerCustom(
                    value: self.$date
                ).padding(20)

                Text("\(self.date.formatISO8601withTZ)")
                Text("\(self.date.formatISO8601)")

            }
        }
    }

}
