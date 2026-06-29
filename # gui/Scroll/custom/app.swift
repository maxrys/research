
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let GRID_COLS = 20
    static let GRID_ROWS = 60
    static let CELL_SIZE: CGFloat = 100

    @StateObject private var scrollController = ScrollController()

    @State private var scrollPositionCurrent: CGPoint = .zero
    @State private var scrollSpeed: Double = 0

    var scrollPositionNearest: CGPoint {
        CGPoint(
            x: (self.scrollPositionCurrent.x / Self.CELL_SIZE).rounded() * Self.CELL_SIZE,
            y: (self.scrollPositionCurrent.y / Self.CELL_SIZE).rounded() * Self.CELL_SIZE
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
            } onScroll: { position, speed in
                self.scrollPositionCurrent = position
                self.scrollSpeed   = speed
                print("\(position.x) : \(position.y) | \(speed)")
            }
            .frame(minWidth: 100, minHeight: 100)
            .overlay(alignment: .bottom) {
                self.InfoPanel()
                    .offset(y: -10)
            }

        }.windowResizability(.contentSize)
    }

    @ViewBuilder func InfoPanel() -> some View {
        VStack(spacing: 10) {
            let currentX = Double(self.scrollPositionCurrent.x).formatted(.number.precision(.fractionLength(1)))
            let currentY = Double(self.scrollPositionCurrent.y).formatted(.number.precision(.fractionLength(1)))
            let nearestX = Double(self.scrollPositionNearest.x).formatted(.number.precision(.fractionLength(1)))
            let nearestY = Double(self.scrollPositionNearest.y).formatted(.number.precision(.fractionLength(1)))
            Text("current: \(currentX) : \(currentY)")
            Text("nearest: \(nearestX) : \(nearestY)")
            Text("speed: \(self.scrollSpeed)")
            Button("scroll to nearest") {
                self.scrollController.scroll(
                    to: CGPoint(x: self.scrollPositionNearest.x, y: self.scrollPositionNearest.y),
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
