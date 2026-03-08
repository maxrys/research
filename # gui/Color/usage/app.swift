
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public var body: some Scene {
        Window("Main", id: "main") {
            VStack {

                self.Message("color Status Ok"     , Color.status.ok)
                self.Message("color Status Warning", Color.status.warning)
                self.Message("color Status Error"  , Color.status.error)

            }.frame(width: 200)
        }
    }

    @ViewBuilder private func Message(_ text: String, _ background: Color) -> some View {
        Text(text)
            .padding(20)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(background)
    }

}
