
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var selectedTab = 0

    var body: some Scene {
        Window("Main", id: "main") {

            TabView {
                Tab("CustomGrid", systemImage: "1.square.fill") {
                    CustomGrid(
                        colsCount: 30,
                        rowsCount: 30,
                        cellSize: 100,
                        cellSpacing: 20,
                        isSticky: true
                    )
                }
                Tab("SnapToGrid", systemImage: "2.square.fill") {
                    SnapToGrid()
                }
                Tab("SnapToElement", systemImage: "3.square.fill") {
                    SnapToElement()
                }
            }

        }.windowResizability(.contentSize)
    }

}
