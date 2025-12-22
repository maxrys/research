
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var isOn: Bool = false

    var body: some Scene {
        WindowGroup {
            TabsCustom {
                TabItemCustom(title: "Update", systemIcon: "pencil.tip.crop.circle") { Text("Tab Update content") }
                TabItemCustom(title: "Insert", systemIcon: "plus.circle"           ) { Text("Tab Insert content") }
                TabItemCustom(title: "Delete", systemIcon: "trash"                 ) { Text("Tab Delete content") }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    init() {
    }

}
