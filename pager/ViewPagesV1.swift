
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ViewPagesV1<Content: View>: View {

    @State private var statePageW: CGFloat = 100
    @State private var statePageH: CGFloat = 100
    @State private var stateScrollPosition: ScrollPosition = ScrollPosition()
    @State private var stateCurrentIndex: Int = 0

    private let isReduceAnimation: ReduceAnimation
    private let count: Int
    private let pages: Content

    init(count: Int, isReduceAnimation: ReduceAnimation = .none, @ViewBuilder pages: @escaping () -> Content) {
        self.isReduceAnimation = isReduceAnimation
        self.count = count
        self.pages = pages()
    }

    var body: some View {
        VStack(spacing: 0) {

            HStack {
                ForEach(0 ..< self.count, id: \.self) { index in
                    Button {
                        self.stateCurrentIndex = index
                        self.updateScrollPosition()
                    } label: {
                        Capsule()
                            .frame(width: 20, height: 10)
                            .foregroundStyle(self.stateCurrentIndex == index ?
                                Color(PAGES_COLORNAME_ITEM_ACTIVE) :
                                Color(PAGES_COLORNAME_ITEM)
                            )
                    }.buttonStyle(.plain)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color(PAGES_COLORNAME_BACKGROUND))
            .padding(.bottom, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(subviews: self.pages) { page in
                        VStack(spacing: 0) {
                            page
                        }.frame(width: self.statePageW)
                    }
                }
            }
            .scrollDisabled(true)
            .scrollPosition(self.$stateScrollPosition)
            .frame(maxWidth: .infinity)
            .onGeometryChange(for: CGSize.self) { geometryProxy in geometryProxy.size } action: { size in
                self.statePageW = size.width
                self.statePageH = size.height
                self.updateScrollPosition()
            }

        }
    }

    func updateScrollPosition() {
        switch self.isReduceAnimation {
            case .none, .half:
                withAnimation(.spring(duration: 1.0)) {
                    self.stateScrollPosition.scrollTo(
                        x: CGFloat(self.stateCurrentIndex) * self.statePageW
                    )
                }
            case .full:
                self.stateScrollPosition.scrollTo(
                    x: CGFloat(self.stateCurrentIndex) * self.statePageW
                )
        }
    }

}

#Preview {
    ViewPagesV1(count: 3) {
        Color(.red)
        Color(.green)
        Color(.blue)
    }.frame(width: 300)
}
