
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let GRID_COLS: UInt8 = 30
    static let GRID_ROWS: UInt8 = 30
    static let GRID_CELL_SIZE: CGFloat = 100.0
    static let GRID_CELL_SPACING: CGFloat = 10.0

    var body: some Scene {
        Window("Main", id: "main") { ScrollView { VStack(spacing: 0) {

            /* MARK: HStack + VStack */

            VStack(spacing: Self.GRID_CELL_SPACING) {
                ForEach(0 ..< Self.GRID_ROWS, id: \.self) { rowNum in HStack(spacing: Self.GRID_CELL_SPACING) {
                ForEach(0 ..< Self.GRID_COLS, id: \.self) { colNum in
                    let ID = UInt16(rowNum) * UInt16(Self.GRID_COLS) + UInt16(colNum)
                    self.cell(ID: ID)
                }}}
            }
            .padding(Self.GRID_CELL_SPACING)
            .background(.red)

            /* MARK: Grid */

            Grid(alignment: .center, horizontalSpacing: Self.GRID_CELL_SPACING, verticalSpacing: Self.GRID_CELL_SPACING) {
                ForEach(0 ..< Self.GRID_ROWS, id: \.self) { rowNum in GridRow {
                ForEach(0 ..< Self.GRID_COLS, id: \.self) { colNum in
                    let ID = UInt16(rowNum) * UInt16(Self.GRID_COLS) + UInt16(colNum)
                    self.cell(ID: ID)
                }}}
            }
            .padding(Self.GRID_CELL_SPACING)
            .background(.green)

            /* MARK: LazyVGrid */

            let columns: [GridItem] = (0 ..< Self.GRID_COLS).map { _ in
                GridItem(.fixed(Self.GRID_CELL_SIZE), spacing: Self.GRID_CELL_SPACING)
            }
            LazyVGrid(columns: columns, spacing: Self.GRID_CELL_SPACING) {
                ForEach(0 ..< Self.GRID_ROWS, id: \.self) { rowNum in
                ForEach(0 ..< Self.GRID_COLS, id: \.self) { colNum in
                    let ID = UInt16(rowNum) * UInt16(Self.GRID_COLS) + UInt16(colNum)
                    self.cell(ID: ID).id(ID)
                }}
            }
            .padding(Self.GRID_CELL_SPACING)
            .background(.blue)

        }}}
    }

    @ViewBuilder func cell(ID: UInt16) -> some View {
        Text("\(ID)")
            .frame(width: Self.GRID_CELL_SIZE, height: Self.GRID_CELL_SIZE)
            .foregroundStyle(.white)
            .background(.black)
    }

}
