
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public var body: some Scene {
        WindowGroup {
            MainScene()
        }
    }

}

struct MainScene: View {

    @State private var dateWithTZ = DatePickerCustom.Value(
        date: Date(iso8601: "2000-01-01 00:00:00")!,
        zone: "UTC"
    )

    public var body: some View {
        VStack(spacing: 10) {

            DatePickerCustom(
                value: self.$dateWithTZ
            ).padding(20)

            Text("\(self.dateWithTZ.result.formatISO8601tzUTC)")

        }
    }

}
