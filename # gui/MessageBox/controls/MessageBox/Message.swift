
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

infix operator ≈≈ : ComparisonPrecedence

struct Message {

    let type: MessageType
    let title: String
    let description: String
    let startedAt: CFTimeInterval
    let expiresAt: CFTimeInterval?

    init(type: MessageType, title: String, description: String = "", expiresAt: CFTimeInterval? = nil) {
        self.type = type
        self.title = title
        self.description = description
        self.expiresAt = expiresAt
        self.startedAt = CACurrentMediaTime()
    }

    static func ≈≈ (lhs: Self, rhs: Self) -> Bool {
        lhs.type        == rhs.type  &&
        lhs.title       == rhs.title &&
        lhs.description == rhs.description
    }

    var isExpired: Bool {
        guard let expiresAt = self.expiresAt else { return false }
        return CACurrentMediaTime() > expiresAt
    }

    var expiredInPercent: Double {
        guard let expiresAt = self.expiresAt else { return 0 }
        let maxValue = expiresAt            - self.startedAt
        let curValue = CACurrentMediaTime() - self.startedAt
        guard maxValue > 0 else { return 0 }
        return (curValue / maxValue).fixBounds(min: 0.0, max: 1.0)
    }

}
