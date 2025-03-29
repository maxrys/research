
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct Equalizer: View {

    var height: Size
    var levelWidth: Size
    var state: EqState

    var body: some View {
        ScrollView(.horizontal) {
            Canvas { context, size in
                for index in 0 ..< self.state.levels.count {
                    let w = self.levelWidth
                    let x = self.levelWidth * Size(index)
                    let canvasVisibleArea = self.state.canvasVisibleAreaMinX ... self.state.canvasVisibleAreaMaxX
                    let objectVisibleArea = x ... x + w
                    if canvasVisibleArea.overlaps(objectVisibleArea) {
                        let level = self.state.levels[index]
                        let value = size.height * level
                        let sliceHeight = size.height / 3
                        let h3 = (value - (sliceHeight * 2)).fixBounds(min: 0, max: sliceHeight)
                        let h2 = (value - (sliceHeight * 1)).fixBounds(min: 0, max: sliceHeight)
                        let h1 = (value - (sliceHeight * 0)).fixBounds(min: 0, max: sliceHeight)
                        let y3 = sliceHeight * 1 - h3
                        let y2 = sliceHeight * 2 - h2
                        let y1 = sliceHeight * 3 - h1
                        if (h3 > 0) { context.fill(Path(CGRect(x: x, y: y3, width: w, height: h3)), with: .color(.red   )) }
                        if (h2 > 0) { context.fill(Path(CGRect(x: x, y: y2, width: w, height: h2)), with: .color(.yellow)) }
                        if (h1 > 0) { context.fill(Path(CGRect(x: x, y: y1, width: w, height: h1)), with: .color(.green )) }
                    }
                }
            }
            .frame(width: self.levelWidth * Size(self.state.levels.count))
            .frame(height: self.height)
        }
        .onScrollGeometryChange(for: Bool.self) { geometry in
            self.state.canvasVisibleAreaMinX = geometry.bounds.minX
            self.state.canvasVisibleAreaMaxX = geometry.bounds.maxX
            return true
        } action: { _, _ in }
    }

}
