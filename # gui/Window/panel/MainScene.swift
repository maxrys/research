
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct MainScene: View {

    static let PANEL_ID = "main"

    @State private var panelAnchorFrame: NSRect = .zero

    var body: some View {
        Button("show panel") {
            _ = NSPanel.makeNewOrShowExisting(ID: Self.PANEL_ID) {
                self.PanelContent()
            }
        }
        self.PanelAnchor()
            .trackFrameOnScreen { frame in
                self.panelAnchorFrame = frame
                self.updatePanelPosition()
            }
    }

    func updatePanelPosition() {
        if let panel = NSPanel.get(Self.PANEL_ID) {
            panel.setFrame(
                NSRect(origin: self.panelAnchorFrame.origin, size: panel.frame.size),
                display: true,
                animate: false
            )
        }
    }

    @ViewBuilder func PanelAnchor() -> some View {
        Rectangle()
            .fill(Color.accentColor)
            .frame(width: 20, height: 20)
            .padding(10)
    }

    @ViewBuilder func PanelContent() -> some View {
        Text("panel content")
            .padding(20)
            .foregroundStyle(.white)
            .background(Color.accentColor)
    }

}
