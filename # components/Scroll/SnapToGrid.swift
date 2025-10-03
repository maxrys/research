
import SwiftUI

struct SnapToGrid: View {

    static let GRID_COLS: Int = 20
    static let GRID_ROWS: Int = 20

    @State private var scrollPosition: ScrollPosition = ScrollPosition()
    @State var iconSize: CGFloat = 100
    @State var iconSpacing: CGFloat = 20

    var scrollFrame: CGFloat {
        self.iconSize + self.iconSpacing
    }

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(spacing: self.iconSpacing) {
                ForEach(0 ..< Self.GRID_ROWS, id: \.self) { rowNum in
                    HStack(spacing: self.iconSpacing) {
                        ForEach(0 ..< Self.GRID_COLS, id: \.self) { colNum in
                            let id = rowNum * Self.GRID_COLS + colNum
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                                .frame(width: self.iconSize, height: self.iconSize)
                                .overlay(
                                    Text("\(id)").foregroundColor(.white)
                                )
                        }
                    }
                }
            }
        }
        .padding(self.iconSpacing)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .scrollDisabled(false)
        .scrollPosition(self.$scrollPosition)
        .onScrollPhaseChange { oldPhase, newPhase, context in
            if (oldPhase != newPhase) {
                if (newPhase == .idle) {
                    self.scrollPosition.scrollTo(
                        x: (context.geometry.contentOffset.x / self.scrollFrame).rounded() * self.scrollFrame,
                        y: (context.geometry.contentOffset.y / self.scrollFrame).rounded() * self.scrollFrame
                    )
                }
            }
        }
    }

}

#Preview {
    SnapToGrid()
}
