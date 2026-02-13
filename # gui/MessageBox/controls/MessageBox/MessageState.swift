
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

final class MessageBoxState: ObservableObject {

    typealias MessageCollection = [UInt: (
        message: Message,
        expirationTimer: Timer.Custom?
    )]

    static let LIFE_TIME_DEFAULT: Double = 3.0

    @Published var messages: MessageCollection = [:]

    var maxID: UInt = 0

    func insert(
        type: MessageType,
        title: String,
        description: String = "",
        lifeTime: Message.LifeTime = .time(MessageBoxState.LIFE_TIME_DEFAULT)
    ) {

        let message = Message(
            type: type,
            title: title,
            description: description
        )

        for current in self.messages {
            if (message == current.value.message) {
                return
            }
        }

        self.maxID += 1

        switch lifeTime {
            case .infinity:
                self.messages[self.maxID] = (
                    message: message,
                    expirationTimer: nil
                )
            case .time(let time):
                self.messages[self.maxID] = (
                    message: message,
                    expirationTimer: Timer.Custom(
                        tag: self.maxID,
                        repeats: .count(1),
                        delay: time,
                        onExpire: { _ in
                            self.messages[self.maxID] = nil
                        }
                    )
                )
        }
    }

}
