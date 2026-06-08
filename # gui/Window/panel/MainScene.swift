
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct MainScene: View {

    static let PANEL_ID = "panelMain"

    @Binding private var windowMainFrame: CGRect
    @State private var panelAnchorFrame: CGRect = .zero

    init(windowMainFrame: Binding<CGRect>) {
        self._windowMainFrame = windowMainFrame
    }

    var body: some View {
        Button("show panel") {
            if NSPanel.makeNewOrShowExistingPanel(ID: Self.PANEL_ID, content: { self.PanelContent() }) {
                self.updatePanelPosition()
            }
        }
        self.PanelAnchor()
            .trackFrameOnScreen { frame in self.panelAnchorFrame = frame }
            .onChange(of: self.windowMainFrame ) { _, _ in self.updatePanelPosition() }
            .onChange(of: self.panelAnchorFrame) { _, _ in self.updatePanelPosition() }
    }

    func updatePanelPosition() {
        if let panel = NSPanel.get(Self.PANEL_ID) {
            panel.setFrame(
                CGRect(origin: CGPoint(
                    x: self.windowMainFrame.x + self.panelAnchorFrame.x,
                    y: self.windowMainFrame.y + self.panelAnchorFrame.y),
                    size: panel.frame.size),
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
