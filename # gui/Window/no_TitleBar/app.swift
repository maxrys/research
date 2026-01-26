
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        WindowGroup {
            Text("Any content")
                .frame(width: 200, height: 50)
                .background(.orange)
                .padding(.bottom, -28)
                .gesture(WindowDragGesture())
                .ignoresSafeArea(.all)
                .onAppear {
                    if let window = NSApplication.shared.windows.first {
                        window.styleMask = [
                            .fullSizeContentView,
                            .titled,
                         // .closable,
                         // .miniaturizable,
                         // .resizable,
                        ]
                    }
                }
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
    }

}
