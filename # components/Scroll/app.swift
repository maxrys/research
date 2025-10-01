
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    var body: some Scene {
        WindowGroup {
            ScrollView([.horizontal]) {
                LazyHStack(spacing: 10) {
                    ForEach(0 ..< 100, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .frame(width: 200, height: 150)
                            .overlay(
                                Text("Item \(index)").foregroundColor(.white)
                            )
                    }
                }.scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .padding(10)
            .frame(width: 400)
        }.windowResizability(.contentSize)
    }

}
