
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {

            TabView {
                Tab("empty"    , systemImage: "1.square.fill") { self.gridCustom(bounds: nil) }
                Tab("single"   , systemImage: "2.square.fill") { self.gridCustom(bounds: .init(minY: 3, maxY: 3, minX: 4, maxX: 4)) }
                Tab("sparse"   , systemImage: "3.square.fill") { self.gridCustom(isSparse: true) }
                Tab("Stacks"   , systemImage: "4.square.fill") { self.gridCustom(gridType: .stacks) }
                Tab("Grid"     , systemImage: "5.square.fill") { self.gridCustom(gridType: .grid) }
                Tab("LazyVGrid", systemImage: "6.square.fill") { self.gridCustom(gridType: .lazyVGrid) }
            }

        }.windowResizability(.contentSize)
    }

    @ViewBuilder func gridCustom(
        bounds: GridCustom.DataSourceBounds? = .init(minY: 0, maxY: 30, minX: 0, maxX: 30),
        isSparse: Bool = false,
        gridType: GridCustom.GridType = .grid
    ) -> some View {
        let cellSize: CGFloat = 100
        let cellSpacing: CGFloat = 2
        let source: GridCustom.DataSource = {
            var result = GridCustom.DataSource()
            if let bounds {
                for rowNum in bounds.minY ... bounds.maxY {
                for colNum in bounds.minX ... bounds.maxX {
                    if (isSparse == false || (isSparse == true && Bool.random())) {
                        let rowNum = CellID.Index(rowNum)
                        let colNum = CellID.Index(colNum)
                        let cellID = CellID(rowNum: rowNum, colNum: colNum)
                        result[rowNum, colNum] = Cell_viewMode(
                            ID: cellID.value,
                            size: cellSize,
                            isVisible: false
                        )
                    }
                }}
            }
            return result
        }()
        GridCustom(
            data: source,
            cellSize: cellSize,
            cellSpacing: cellSpacing,
            isSticky: true,
            gridType: gridType
        )
    }

}
