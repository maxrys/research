
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        WindowGroup {
            TabCustom {
                TabCustom_Item(title: NSLocalizedString("Update", comment: ""), icon: Image(systemName: "pencil.tip.crop.circle")) { Text("Tab Update content").padding(20) }
                TabCustom_Item(title: NSLocalizedString("Insert", comment: ""), icon: Image(systemName: "plus.circle"           )) { Text("Tab Insert content").padding(20) }; TabCustom_Spacer()
                TabCustom_Item(title: NSLocalizedString("Delete", comment: ""), icon: Image(systemName: "trash"                 )) { Text("Tab Delete content").padding(20) }
            }
        }
    }

}
