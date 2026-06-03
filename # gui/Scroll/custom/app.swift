
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let GRID_COLS = 20
    static let GRID_ROWS = 20

    @StateObject private var scrollController = ScrollController()

    @State private var scrollPosition: CGPoint = .zero

    let cellSize: CGFloat = 100

    var nearest: CGPoint {
        CGPoint(
            x: (self.scrollPosition.x / self.cellSize).rounded() * self.cellSize,
            y: (self.scrollPosition.y / self.cellSize).rounded() * self.cellSize
        )
    }

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
                            .frame(width: self.cellSize, height: self.cellSize)
                            .overlay {
                                Text("\(rowNum):\(colNum)")
                            }
                    }}}
                }
            } onScroll: { position in self.scrollPosition = position }
            .frame(minWidth: 100, minHeight: 100)
            .overlay(alignment: .bottom) {
                VStack (spacing: 10) {
                    Text("current: \(self.scrollPosition.x) : \(self.scrollPosition.y)")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                    Text("nearest: \(self.nearest.x) : \(self.nearest.y)")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                    Button("scroll to nearest") {
                        self.scrollController.scroll(
                            to: CGPoint(x: self.nearest.x, y: self.nearest.y),
                            animated: true
                        )
                    }
                }.offset(y: -10)
            }

        }.windowResizability(.contentSize)
    }

}
