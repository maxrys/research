
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct MainScene: View {

    static let PANEL_ID = "main"

    @State private var isShowPanel = false

    var body: some View {
        Rectangle()
            .fill(self.isShowPanel ? Color.accentColor : Color.gray)
            .frame(width: 20, height: 20)
            .padding(10)
            .onHover { isShow in
                self.isShowPanel = isShow
                _ = NSPanel.makeNewOrShowExisting(ID: Self.PANEL_ID) {
                    self.PanelContent()
                }
            }
    }

    @ViewBuilder func PanelContent() -> some View {
        Text("panel content")
            .padding(20)
            .foregroundStyle(.white)
            .background(Color.accentColor)
    }

}
