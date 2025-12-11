
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct CustomGrid: View {

    @State private var scrollPosition: ScrollPosition = ScrollPosition()
    @State private var scrollPhase: ScrollPhase = .idle
    @State private var visibleFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    @State private var stickyGridDelayTimer: Timer.Custom!
    @State private var stickyGridTimer: Timer.Custom!
    @State private var cellsVisibilityDelayTimer: Timer.Custom!
    @State private var cellsVisibility: [CellID: Bool] = [:]

    private let colsCount: UInt
    private let rowsCount: UInt
    private let cellSize: CGFloat
    private let cellSpacing: CGFloat
    private let isSticky: Bool

    init(
        colsCount: UInt,
        rowsCount: UInt,
        cellSize: CGFloat,
        cellSpacing: CGFloat,
        isSticky: Bool
    ) {
        self.colsCount = colsCount
        self.rowsCount = rowsCount
        self.cellSize = cellSize
        self.cellSpacing = cellSpacing
        self.isSticky = isSticky
    }

    private var gridBounds: CGSize {
        let colsCount = CGFloat(self.colsCount)
        let rowsCount = CGFloat(self.rowsCount)
        let gridSizeW = (self.cellSize * colsCount) + (self.cellSpacing * (colsCount + 1))
        let gridSizeH = (self.cellSize * rowsCount) + (self.cellSpacing * (rowsCount + 1))
        return CGSize(width: gridSizeW, height: gridSizeH)
    }

    private var cellBounds: [CellID: CGRect] {
        var result: [CellID: CGRect] = [:]
        for rowNum in 0 ..< self.rowsCount {
        for colNum in 0 ..< self.colsCount {
            let colNum = CGFloat(colNum)
            let rowNum = CGFloat(rowNum)
            let cellID = CellID(UInt16(rowNum) * UInt16(self.colsCount) + UInt16(colNum))
            let cellFrameMinX = (self.cellSize * colNum) + (self.cellSpacing * (colNum + 1))
            let cellFrameMinY = (self.cellSize * rowNum) + (self.cellSpacing * (rowNum + 1))
            result[cellID] = CGRect(
                x     : cellFrameMinX,
                y     : cellFrameMinY,
                width : self.cellSize,
                height: self.cellSize
            )
        }}
        return result
    }

    public var body: some View {

        let isScrollDisabled: Bool = {
            let gridBounds = self.gridBounds;
            return gridBounds.width  < self.visibleFrame.size.width &&
                   gridBounds.height < self.visibleFrame.size.height
        }()

        ScrollView([.horizontal, .vertical]) { self.grid }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollDisabled(isScrollDisabled)
            .scrollPosition(self.$scrollPosition)
            .onScrollPhaseChange { oldPhase, newPhase, context in
                if (oldPhase != newPhase) {
                    self.scrollPhase = newPhase
                    self.visibleFrame = CGRect(origin: context.geometry.contentOffset, size: context.geometry.visibleRect.size)
                    self.cellsVisibilityUpdate()
                    if (self.isSticky) {
                        self.makeSticky()
                    }
                }
            }
            .onGeometryChange(for: CGSize.self) { geometry in geometry.size } action: { size in
                self.visibleFrame.size = size
                self.cellsVisibilityUpdate()
            }
    }

    @ViewBuilder private var grid: some View {

        let columns: [GridItem] = (0 ..< self.colsCount).map { _ in
            GridItem(.fixed(self.cellSize), spacing: self.cellSpacing)
        }

        LazyVGrid(columns: columns, spacing: self.cellSpacing) {
            ForEach(0 ..< self.rowsCount, id: \.self) { rowNum in
            ForEach(0 ..< self.colsCount, id: \.self) { colNum in
                let cellID = CellID(UInt16(rowNum) * UInt16(self.colsCount) + UInt16(colNum))
                Cell(
                    ID: cellID,
                    size: self.cellSize,
                    isVisible: self.cellsVisibility[cellID] ?? false
                )
                .zIndex(Double(self.rowsCount - rowNum))
                .id(cellID)
            }}
        }.padding(self.cellSpacing)

    }

    private func cellsVisibilityUpdate() {
        self.cellsVisibilityDelayTimer?.stopAndReset()
        if (self.scrollPhase == .idle) {
            self.cellsVisibilityDelayTimer = Timer.Custom(
                count: 1,
                interval: 0.1,
                onExpire: {
                    let cellBounds = self.cellBounds
                    for (cellID, cellBounds) in cellBounds {
                        self.cellsVisibility[cellID] = self.visibleFrame.intersects(cellBounds)
                    }
                }
            )
        }
    }

    private func makeSticky() {
        self.stickyGridDelayTimer?.stopAndReset()
        self.stickyGridTimer?.stopAndReset()
        if (self.scrollPhase == .idle) {
            self.stickyGridDelayTimer = Timer.Custom(
                count: 1,
                interval: 0.4,
                onExpire: {
                    let cellFrameSize = self.cellSize + self.cellSpacing
                    let toX = (self.visibleFrame.minX / cellFrameSize).rounded() * cellFrameSize
                    let toY = (self.visibleFrame.minY / cellFrameSize).rounded() * cellFrameSize
                    if (toX != self.visibleFrame.minX || toY != self.visibleFrame.minY) {
                        let stepsCount: UInt16 = 10
                        let stepX = (toX - self.visibleFrame.minX) / CGFloat(stepsCount)
                        let stepY = (toY - self.visibleFrame.minY) / CGFloat(stepsCount)
                        self.stickyGridTimer = Timer.Custom(
                            count: stepsCount,
                            interval: 0.01,
                            onTick: { i in
                                Task {
                                    self.scrollPosition.scrollTo(
                                        x: self.visibleFrame.minX + (CGFloat(i) * stepX),
                                        y: self.visibleFrame.minY + (CGFloat(i) * stepY)
                                    )
                                }
                            }
                        )
                    }
                }
            )
        }
    }

}

#Preview {
    CustomGrid(
        colsCount: 30,
        rowsCount: 30,
        cellSize: 100,
        cellSpacing: 20,
        isSticky: true
    )
}
