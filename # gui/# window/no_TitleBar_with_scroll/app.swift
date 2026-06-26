
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        WindowGroup {
            ScrollView {
                ForEach(0 ..< 100, id: \.self) { num in
                    Text("Line \(num)")
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
            .background(.orange)
            .gesture(WindowDragGesture())
            .ignoresSafeArea(.all)
            .onAppear {
                if let window = NSApplication.shared.windows.first {
                    window.standardWindowButton(.closeButton)?.isHidden = true
                    window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                    window.standardWindowButton(.zoomButton)?.isHidden = true
                }
            }
        }
        .windowStyle(.hiddenTitleBar)
    }

}
