
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let GRID_COLS = 20
    static let GRID_ROWS = 20

    @StateObject private var scrollController = ScrollController()

    var body: some Scene {
        Window("Main", id: "main") {

            ScrollCustom(controller: self.scrollController) {

                Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
                    ForEach(0 ..< ThisApp.GRID_ROWS, id: \.self) { rowNum in GridRow {
                    ForEach(0 ..< ThisApp.GRID_COLS, id: \.self) { colNum in
                        let isDarkCell =
                            (rowNum % 2 == 0 && colNum % 2 != 0) ||
                            (rowNum % 2 != 0 && colNum % 2 == 0)
                        Rectangle()
                            .fill(isDarkCell ? .gray : .white)
                            .frame(width: 100, height: 100)
                            .overlay {
                                Text("\(rowNum):\(colNum)")
                            }
                    }}}
                }
            } onScroll: { point in
                print("\(point.x) : \(point.y)")
            }
            .overlay(alignment: .topLeading) {
                Button("scroll") {
                    self.scrollController.scroll(
                        to: CGPoint(x: 0, y: 100),
                        animated: true
                    )
                }.offset(x: 10, y: 10)
            }

        }.windowResizability(.contentSize)
    }

}
