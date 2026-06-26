
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State var value: String = ""

    var body: some Scene {
        WindowGroup {
            FieldSearchCustom(
                text: self.$value
            )
            .padding(20)
            .onChange(of: self.value) { newValue in
                print(newValue)
            }
        }
    }

}
