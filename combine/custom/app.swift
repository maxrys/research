
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import Combine

@main struct ThisApp: App {

    private var publisher: Cancellable?

    var body: some Scene {
        WindowGroup {
            Text("PublisherCustom")
        }
    }

    init() {
        self.publisher = PublisherCustom(count: 10)
            .sink(receiveCompletion: { _ in
                print("finish")
            }, receiveValue: { value in
                print("\(value)")
            })
    }

}
