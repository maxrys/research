
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @StateObject private var scrollController = ScrollController()

    var body: some Scene {
        Window("Main", id: "main") {

            ScrollCustom(controller: self.scrollController) {
                VStack (spacing: 0) {
                    ForEach(0 ..< 200) { i in
                        Text("Cell \(i)")
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                            .background(
                                i % 2 == 0 ? .gray : .white
                            )
                    }
                }
            } onScroll: { point in
                print("\(point.x) : \(point.y)")
            }
            .frame(width: 600, height: 600)
            .overlay(alignment: .topLeading) {
                Button("scroll") {
                    self.scrollController.scroll(
                        to: CGPoint(x: 0, y: 100),
                        animated: true
                    )
                }.offset(x: 10, y: 10)
            }

        }.windowResizability(.contentSize)
    }

}
