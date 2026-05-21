
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct MainScene: View {

    static let WINDOW_MAIN_ID = "main"

    @State private var frame: CGRect = .zero

    var body: some View {
        VStack {
            Button("←") { /* if let window = NSWindow.get(Self.WINDOW_MAIN_ID) {} */ }
            Button("→") { /* if let window = NSWindow.get(Self.WINDOW_MAIN_ID) {} */ }
            Button("↑") { /* if let window = NSWindow.get(Self.WINDOW_MAIN_ID) {} */ }
            Button("↓") { /* if let window = NSWindow.get(Self.WINDOW_MAIN_ID) {} */ }
            Text("X = \(self.frame.minX ) : Y = \(self.frame.minY  )")
            Text("W = \(self.frame.width) : H = \(self.frame.height)")
        }
        .padding(40)
        .onWinResize { window in
            self.frame = window.frame
        }
        .onWinMove { window in
            self.frame = window.frame
        }
        .onAppear {
            if let window = NSWindow.get(Self.WINDOW_MAIN_ID) {
                self.frame = window.frame
            }
        }
        .onChange(of: frame) { _, newValue in
        }
    }

    init() {
        NSWindow.onChangeRect(Self.WINDOW_MAIN_ID) { window in
            dump(window.frame)
        }
    }

}
