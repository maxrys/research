
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MainView: View {

    var body: some View {
        VStack {
            Button("Open Window ID = 1") { NSWindow.show(ID: "id=1") }
            Button("Open Window ID = 2") { NSWindow.show(ID: "id=2") }
            Button("Open Window ID = 3") { NSWindow.show(ID: "id=3") }
        }
        .padding(20)
    }

}

#Preview {
    MainView()
}
