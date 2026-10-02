
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

    final class DemoState: ObservableObject {
        static public private(set) var shared = DemoState()
        @Published var count: UInt = 0
    }

    struct DemoView: View {
        @StateObject private var state = DemoState.shared
        public var body: some View {
            VStack(spacing: 10) {
                ForEach(0 ..< Int(self.state.count), id: \.self) { i in
                    Text("Item \(i)")
                }
            }
        }
    }

    @ObservedObject static private var count = ValueState<UInt>(0)

    @ObservedObject static private var previewMode = ValueState<UInt>(0) { value in
        switch value {
            case 0: DemoState.shared.count =  0
            case 1: DemoState.shared.count =  5
            case 2: DemoState.shared.count = 10
            case 3: DemoState.shared.count = 20
            case 4: DemoState.shared.count = 30
            default: break
        }
    }

    public var body: some View {
        VStack(spacing: 0) {
            ScrollCustom(axis: .vertical, aligment: .top, scrollAfter: .init(width: 200, height: 200)) {
                DemoView()
            }.background(Color.gray)
            PreviewMode(
                title: "count",
                state: Self.previewMode,
                modes: ["0", "5", "10", "20", "30"]
            )
        }.frame(
            width: 200, height: 280
        )
    }

}
