
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ViewScroll: View {

    @Namespace var scrollToRight
    @State var items: [Int] = []

    var body: some View {
        ScrollViewReader { scrollProxy in

            Button("Add New Item and Scroll to right") {
                self.items.append(self.items.count + 1)
             // scrollProxy.scrollTo(scrollToRight)
            }

            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    HStack(spacing: 10) {
                        ForEach(self.items.sorted(), id: \.self) { value in
                            Text("\(value)")
                        }
                    }
                    .onGeometryChange(for: CGSize.self) { geoProxy in geoProxy.size } action: { _ in
                        scrollProxy.scrollTo(scrollToRight) // scroll is here
                    }
                    Color.clear
                        .frame(width: .zero, height: .zero)
                        .id(scrollToRight)
                }
                .padding(20)
                .background(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .border(.black)

        }.frame(width: 300, height: 200)
    }

}

#Preview {
    ViewScroll()
}
