
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var isOn: Bool = false

    var body: some Scene {
        WindowGroup {
            TabsCustom([
                0: (title: "Update", systemIcon: "pencil"     , view: TabUpdate()),
                1: (title: "Insert", systemIcon: "plus.circle", view: TabInsert()),
                2: (title: "Delete", systemIcon: "trash"      , view: TabDelete()),
            ]).frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    init() {
    }

}
