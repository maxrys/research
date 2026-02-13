
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Message: Hashable {

    enum LifeTime {
        case infinity
        case time(Double)
    }

    static let LIFE_TIME: Double = 3.0

    let type: MessageType
    let title: String
    let description: String

    init(type: MessageType, title: String, description: String = "") {
        self.type = type
        self.title = title
        self.description = description
    }

}
