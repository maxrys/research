
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

typealias MessageID = UInt

final class MessageBoxState: ObservableObject {

    @Published var messages: [MessageID: Message] = [:]
    @Published var progress: [MessageID: Double ] = [:]

    var newID: MessageID = 0

    func insert(
        type: MessageType,
        title: String,
        description: String = "",
        isClosable: Bool = false,
        expiresAt: CFTimeInterval? = nil
    ) {
        let newMessage = Message(
            type: type,
            title: title,
            description: description,
            isClosable: isClosable,
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
