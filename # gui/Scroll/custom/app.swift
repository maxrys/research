
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        WindowGroup {
            MainScene()
        }
    }

}

struct MainScene: View {

    @ObservedObject static private var count = ValueState<UInt>(0)

    public var body: some View {
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
