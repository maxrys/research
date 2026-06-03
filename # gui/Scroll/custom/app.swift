
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let GRID_COLS = 20
    static let GRID_ROWS = 60
    static let CELL_SIZE: CGFloat = 100

    @StateObject private var scrollController = ScrollController()

    @State private var scrollCurrent: CGPoint = .zero

    var scrollNearest: CGPoint {
        CGPoint(
            x: (self.scrollCurrent.x / Self.CELL_SIZE).rounded() * Self.CELL_SIZE,
            y: (self.scrollCurrent.y / Self.CELL_SIZE).rounded() * Self.CELL_SIZE
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
                            .frame(width: Self.CELL_SIZE, height: Self.CELL_SIZE)
                            .overlay {
                                Text("\(rowNum):\(colNum)")
                            }
                    }}}
                }
            } onScroll: { position in
                self.scrollCurrent = position
                print("\(position.x) : \(position.y)")
            }
            .frame(minWidth: 100, minHeight: 100)
            .overlay(alignment: .bottom) {
                self.InfoPanel()
                    .offset(y: -10)
            }

        }.windowResizability(.contentSize)
    }

    @ViewBuilder func InfoPanel() -> some View {
        VStack (spacing: 10) {
            let currentX = Double(self.scrollCurrent.x).formatted(.number.precision(.fractionLength(1)))
            let currentY = Double(self.scrollCurrent.y).formatted(.number.precision(.fractionLength(1)))
            let nearestX = Double(self.scrollNearest.x).formatted(.number.precision(.fractionLength(1)))
            let nearestY = Double(self.scrollNearest.y).formatted(.number.precision(.fractionLength(1)))
            Text("current: \(currentX) : \(currentY)")
            Text("nearest: \(nearestX) : \(nearestY)")
            Button("scroll to nearest") {
                self.scrollController.scroll(
                    to: CGPoint(x: self.scrollNearest.x, y: self.scrollNearest.y),
                    animated: true
                )
            }
        }
        .padding(10)
        .foregroundStyle(.white)
        .background(Color.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

}
