
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var isOn: Bool = false

    var body: some Scene {
        WindowGroup {
            TabsCustom {
                TabItemCustom(title: "Update", systemIcon: "pencil"     ) { TabUpdate() }
                TabItemCustom(title: "Insert", systemIcon: "plus.circle") { TabInsert() }
                TabItemCustom(title: "Delete", systemIcon: "trash"      ) { TabDelete() }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    init() {
    }

}
