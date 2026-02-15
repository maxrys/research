
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

typealias MessageID = UInt

final class MessageBoxState: ObservableObject {

    typealias MessageProgressPair = (message: Message, progress: Double)

    @Published private var data: [
        MessageID: MessageProgressPair
    ] = [:]

    private var timer: Timer.Custom!
    private var newID: MessageID = 0

    init() {
        self.timer = Timer.Custom(
            repeats: .infinity,
            delay: 0.5,
            onTick: self.onTimerTick
        )
    }

    private func onTimerTick(timer: Timer.Custom) {
        Logger.customLog("Timer onTimerTick \(timer.i)")
        for (ID, pair) in self.data {
            self.data[ID]?.progress = pair.message.progress
            if (pair.message.isExpired) {
                self.delete(ID)
            }
        }
    }

    public var messages: [(key: MessageID, value: Message)] {
        self.data.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).map { dictItem in (
             key  : dictItem.key,
             value: dictItem.value.message
        )}
    }

    public func progress(_ ID: MessageID) -> Double {
        self.data[ID]?.progress ?? 0
    }

    public func insert(type: MessageType, title: String, description: String = "", isClosable: Bool = false, expiresAt: CFTimeInterval? = nil) {
        let newMessage = Message(
            type: type,
            title: title,
            description: description,
            isClosable: isClosable,
            expiresAt: expiresAt
        )
        for (_, pair) in self.data {
            if (newMessage ≈≈ pair.message) {
                return
            }
        }
        self.newID += 1
        self.data[self.newID] = (
            message: newMessage, progress: newMessage.progress
        )
    }

    public func delete(_ ID: MessageID) {
        self.data[ID] = nil
    }

}
