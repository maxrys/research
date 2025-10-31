
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct Item: Identifiable {
    var id: Int
    var title: String
}

@main struct ThisApp: App {

    @State private var selectedItem: Item?

    let items: [Item] = {
        (0 ..< 100).reduce(into: [Item]()) { result, i in
            result.append(
                Item(id: i, title: "Item \(i + 1)")
            )
        }
    }()

    var body: some Scene {
        WindowGroup {
            HStack {

                FocusableListView(
                    items: self.items,
                    selectedItem: self.$selectedItem
                )

                VStack {
                    if let item = self.selectedItem {
                        Text("Selected item ID: \(item.id)")
                        Text("Selected item Title: \(item.title)")
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
