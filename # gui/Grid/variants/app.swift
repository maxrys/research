
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let GRID_COLS = 10
    static let GRID_ROWS = 10

    let cellSize: CGFloat = 30
    let cellSpacing: CGFloat = 10

    var body: some Scene {
        Window("Main", id: "main") { ScrollView { VStack(spacing: 0) {

            /* MARK: HStack + VStack */

            VStack(spacing: self.cellSpacing) {
                ForEach(0 ..< ThisApp.GRID_ROWS, id: \.self) { rowNum in HStack(spacing: self.cellSpacing) {
                ForEach(0 ..< ThisApp.GRID_COLS, id: \.self) { colNum in
                    self.cell(id: rowNum * ThisApp.GRID_COLS + colNum)
                }}}
            }
            .padding(self.cellSpacing)
            .background(.red)

            /* MARK: Grid */

            Grid(alignment: .center, horizontalSpacing: self.cellSpacing, verticalSpacing: self.cellSpacing) {
                ForEach(0 ..< ThisApp.GRID_ROWS, id: \.self) { rowNum in GridRow {
                ForEach(0 ..< ThisApp.GRID_COLS, id: \.self) { colNum in
                    self.cell(id: rowNum * ThisApp.GRID_COLS + colNum)
                }}}
            }
            .padding(self.cellSpacing)
            .background(.green)

            /* MARK: LazyVGrid */

            let columns: [GridItem] = (0 ..< ThisApp.GRID_COLS).map { _ in
                GridItem(.fixed(self.cellSize), spacing: self.cellSpacing)
            }
            LazyVGrid(columns: columns, spacing: self.cellSpacing) {
                ForEach(0 ..< ThisApp.GRID_ROWS, id: \.self) { rowNum in
                ForEach(0 ..< ThisApp.GRID_COLS, id: \.self) { colNum in
                    let id = rowNum * ThisApp.GRID_COLS + colNum
                    self.cell(id: id).id(id)
                }}
            }
            .padding(self.cellSpacing)
            .background(.blue)

        }}}
    }

    @ViewBuilder func cell(id: Int) -> some View {
        Text("\(id)")
            .frame(width: self.cellSize, height: self.cellSize)
            .foregroundStyle(.white)
            .background(.black)
    }

}
