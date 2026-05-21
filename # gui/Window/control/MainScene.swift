
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct MainScene: View {

    public let frame: CGRect
    public let onFrameManualChange: (CGRect) -> Void

    var body: some View {
        VStack {

            HStack {
                Text("x").font(.headline)
                Button("←") { var newFrame = self.frame; newFrame.x -= 100; self.onFrameManualChange(newFrame) }
                Button("→") { var newFrame = self.frame; newFrame.x += 100; self.onFrameManualChange(newFrame) }
            }

            HStack {
                Text("y").font(.headline)
                Button("↓") { var newFrame = self.frame; newFrame.y -= 100; self.onFrameManualChange(newFrame) }
                Button("↑") { var newFrame = self.frame; newFrame.y += 100; self.onFrameManualChange(newFrame) }
            }

            HStack {
                Text("w").font(.headline)
                Button("←") { var newFrame = self.frame; newFrame.w -= 100; self.onFrameManualChange(newFrame) }
                Button("→") { var newFrame = self.frame; newFrame.w += 100; self.onFrameManualChange(newFrame) }
            }

            HStack {
                Text("h").font(.headline)
                Button("↓") { var newFrame = self.frame; newFrame.h -= 100; self.onFrameManualChange(newFrame) }
                Button("↑") { var newFrame = self.frame; newFrame.h += 100; self.onFrameManualChange(newFrame) }
            }

            Text("X = \(self.frame.x) : Y = \(self.frame.y)")
            Text("W = \(self.frame.w) : H = \(self.frame.h)")

        }.padding(40)
    }

}
