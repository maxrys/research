
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

enum ReduceAnimation {
    case none
    case half
    case full
}

let PAGES_COLORNAME_ITEM        = "color Pages Item"
let PAGES_COLORNAME_ITEM_ACTIVE = "color Pages Item Active"
let PAGES_COLORNAME_BACKGROUND  = "color Pages Background"

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {

            ViewScroll()

            ViewPagesV1(count: 3) {
                Color(.red)
                Color(.green)
                Color(.blue)
            }

            ViewPagesV2(isReduceAnimation: .none) {
                Color(.red)
                Color(.green)
                Color(.blue)
            }

        }
    }

}
