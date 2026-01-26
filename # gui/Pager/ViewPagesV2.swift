
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ViewPagesV2<Content: View>: View {

    @State private var statePageWidth: CGFloat = 100
    @State private var stateCurrentId: Subview.ID?

    private let isReduceAnimation: ReduceAnimation
    private let pages: Content

    init(isReduceAnimation: ReduceAnimation = .none, @ViewBuilder pages: @escaping () -> Content) {
        self.isReduceAnimation = isReduceAnimation
        self.pages = pages()
    }

    @ViewBuilder func getPagerItem(colorName: String) -> some View {
        Capsule()
            .frame(width: 20, height: 10)
            .foregroundStyle(
                Color(colorName)
            )
    }

    var body: some View {
        ScrollViewReader { scrollProxy in

            HStack {
                HStack(spacing: 8) {
                    ForEach(subviews: self.pages) { page in
                        Button {
                            self.stateCurrentId = page.id
                            switch self.isReduceAnimation {
                                case .none, .half:
                                    withAnimation(.spring(duration: 1.0)) {
                                        scrollProxy.scrollTo(page.id)
                                    }
                                case .full:
                                    scrollProxy.scrollTo(page.id)
                            }
                        } label: {
                            self.getPagerItem(
                                colorName: self.stateCurrentId == page.id ?
                                    PAGES_COLORNAME_ITEM_ACTIVE :
                                    PAGES_COLORNAME_ITEM
                            )
                        }.buttonStyle(.plain)
                    }
                }.overlay(alignment: .leading) {
                    if self.stateCurrentId == nil {
                        self.getPagerItem(
                            colorName: PAGES_COLORNAME_ITEM_ACTIVE
                        )
                    }
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color(PAGES_COLORNAME_BACKGROUND))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(subviews: self.pages) { page in
                        VStack(spacing: 0) {
                            page
                        }.frame(width: self.statePageWidth)
                         .id(page.id)
                    }
                }
            }
            .scrollDisabled(true)
            .frame(maxWidth: .infinity)
            .onGeometryChange(for: CGSize.self) { geometryProxy in geometryProxy.size } action: { size in
                self.statePageWidth = size.width
                if (self.stateCurrentId != nil) {
                    scrollProxy.scrollTo(self.stateCurrentId)
                }
            }

        }
    }

}

#Preview {
    ViewPagesV2 {
        Color(.red)
        Color(.green)
        Color(.blue)
    }.frame(width: 300)
}
