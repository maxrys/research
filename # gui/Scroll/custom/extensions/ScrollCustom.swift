
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

private struct SizeKey: PreferenceKey {
    static var defaultValue = CGSize(width: 0, height: 0)
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ScrollCustom<Content: View>: View {

    @State private var size = CGSize(width: 0, height: 0)

    private var isLessBoxLimits: Bool {
        self.size.width  <= self.limits.width &&
        self.size.height <= self.limits.height
    }

    private let axis: Axis.Set
    private let limits: CGSize
    private let content: () -> Content

    init(
        axis: Axis.Set,
        scrollAfter limits: CGSize,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.axis = axis
        self.limits = limits
        self.content = content
    }

    public var body: some View {
        let finalContent = self.FinalContentView()
        if (self.isLessBoxLimits) { finalContent } else {
            ScrollView(self.axis) { finalContent }.frame(
                maxWidth : self.limits.width,
                maxHeight: self.limits.height
            )
        }
    }

    @ViewBuilder func FinalContentView() -> some View {
        ZStack {
            Color.clear.background(
                GeometryReader { geometry in
                    Color.clear.preference(key: SizeKey.self, value: geometry.size)
                }
            )
            .onPreferenceChange(SizeKey.self) { size in
                self.size = size
            }
            self.content()
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct ScrollCustom_Previews: PreviewProvider {

    struct ViewWithState: View {

        @ObservedObject static private var count = ValueState<UInt>(0)

        var body: some View {
            VStack(spacing: 0) {
                ScrollCustom(axis: .vertical, scrollAfter: .init(width: 200, height: 200)) {
                    VStack(spacing: 10) {
                        ForEach(0 ..< Int(Self.count.value), id: \.self) { i in
                            Text("Item \(i)")
                        }
                    }
                }
                PreviewMode(
                    title: "count",
                    state: Self.count,
                    modes: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                )
            }.frame(
                width: 240
            )
        }

    }

    static var previews: some View {
        ViewWithState()
    }

}
