
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

infix operator ≈≈ : ComparisonPrecedence

struct Message {

    let type: MessageType
    let title: String
    let description: String
    let expiresAt: CFTimeInterval?

    init(type: MessageType, title: String, description: String = "", expiresAt: CFTimeInterval? = nil) {
        self.type = type
        self.title = title
        self.description = description
        self.expiresAt = expiresAt
    }

    static func ≈≈ (lhs: Self, rhs: Self) -> Bool {
        lhs.type        == rhs.type  &&
        lhs.title       == rhs.title &&
        lhs.description == rhs.description
    }

}
