
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    typealias Key = UInt

    @State private var selectedItem: Key?

    let items: [Key: String] = {
        (1000 ..< 1100).reduce(into: [Key: String]()) { result, i in
            result[Key(i)] = "Item \(i)"
        }
    }()

    var body: some Scene {
        WindowGroup {
            HStack {

                FocusableListView<Key>(
                    items: self.items,
                    selectedKey: self.$selectedItem
                )

                VStack {
                    if let key = self.selectedItem {
                        Text("Selected item Key: \(key)")
                        Text("Selected item Title: \(self.items[key] ?? "-")")
                    } else {
                        Text("Nothing selected")
                    }
                }.frame(width: 200)

            }
        }
    }

    init() {

    }

}
