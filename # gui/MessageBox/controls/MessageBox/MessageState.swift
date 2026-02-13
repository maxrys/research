
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

final class MessageBoxState: ObservableObject {

    @Published var messages: [UInt: Message] = [:]

    var newID: UInt = 0

    func insert(type: MessageType, title: String, description: String = "", expiresAt: CFTimeInterval? = nil) {
        let newMessage = Message(
            type: type,
            title: title,
            description: description,
            expiresAt: expiresAt
        )
        for (_, messsage) in self.messages {
            if (newMessage ≈≈ messsage) {
                return
            }
        }
        self.newID += 1
        self.messages[self.newID] = newMessage
    }

}
