
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {

            TabView {
                Tab("empty"    , systemImage: "1.square.fill") { self.gridCustom(bounds: nil) }
                Tab("single"   , systemImage: "2.square.fill") { self.gridCustom(bounds: .init(minRow: 3, maxRow: 3, minCol: 4, maxCol: 4)) }
                Tab("sparse"   , systemImage: "3.square.fill") { self.gridCustom(isSparse: true) }
                Tab("Stacks"   , systemImage: "4.square.fill") { self.gridCustom(gridType: .stacks) }
                Tab("Grid"     , systemImage: "5.square.fill") { self.gridCustom(gridType: .grid) }
                Tab("LazyVGrid", systemImage: "6.square.fill") { self.gridCustom(gridType: .lazyVGrid) }
            }

        }.windowResizability(.contentSize)
    }

    @ViewBuilder func gridCustom(
        bounds: GridCustom.DataSource.Bounds? = .init(minRow: 0, maxRow: 30, minCol: 0, maxCol: 30),
        isSparse: Bool = false,
        gridType: GridCustom.GridType = .grid
    ) -> some View {
        let cellSize: CGFloat = 100
        let cellSpacing: CGFloat = 2
        let source: GridCustom.DataSource = {
            var result = GridCustom.DataSource()
            if let bounds {
                for rowNum in bounds.minRow ... bounds.maxRow {
                for colNum in bounds.minCol ... bounds.maxCol {
                    if (isSparse == false || (isSparse == true && Bool.random())) {
                        let cellID = CellIDValue(
                            rowNum: CellIDValue.Index(rowNum),
                            colNum: CellIDValue.Index(colNum)
                        )
                        result[cellID.raw] = Cell_viewMode(
                            ID: cellID.raw,
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
