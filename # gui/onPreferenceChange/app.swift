
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import QuartzCore

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {
            StickyScrollView()
        }
    }

    init() {
    }

}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct StickyScrollView: View {

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0 ..< 20) { index in
                    if (index == 10) {
                        StickyElement()
                            .background {
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(
                                            key: ScrollOffsetKey.self,
                                            value: geometry.frame(in: .global).minY
                                        )
                                        .onPreferenceChange(ScrollOffsetKey.self) { value in
                                            print("value: \(value)")
                                        }
                                }
                            }
                    } else {
                        Element(index: index)
                    }
                }
            }
        }
    }

}

struct Element: View {
    var index: Int
    var body: some View {
        Text("Item \(self.index)")
            .frame(width: 100, height: 100)
            .padding(10)
            .background(Color.blue)
            .cornerRadius(8)
    }
}

struct StickyElement: View {
    var body: some View {
        Text("Sticky Element")
            .frame(width: 100, height: 100)
            .padding(10)
            .background(Color.red)
            .cornerRadius(8)
    }
}
