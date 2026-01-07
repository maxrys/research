
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
                    self.gridCustom
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

    @ViewBuilder var gridCustom: some View {
        let colsCount: GridCellsByAxisCount = 30
        let rowsCount: GridCellsByAxisCount = 30
        let cellSize: CGFloat = 100
        let cellSpacing: CGFloat = 20
        let source: GridCustom.DataSource = {
            var result: GridCustom.DataSource = [:]
            for rowNum in 0 ..< rowsCount {
            for colNum in 0 ..< colsCount {
                if (result[rowNum] == nil) { result[rowNum] = [:] }
                let cellID = CellID(UInt16(rowNum) * UInt16(colsCount) + UInt16(colNum))
                result[rowNum]![colNum] = Cell(
                    ID: cellID,
                    size: cellSize,
                    isVisible: false
                )
            }}
            return result
        }()
        GridCustom(
            data: source,
            cellSize: cellSize,
            cellSpacing: cellSpacing,
            isSticky: true
        )
    }

}
