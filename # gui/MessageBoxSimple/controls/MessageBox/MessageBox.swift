
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MessageBox: View {

    typealias MessageCollection = [UInt: (
        message: Message,
        expirationTimer: Timer.Custom?
    )]

    @ObservedObject private var messages = ValueState<MessageCollection>([:])
    @ObservedObject private var messageCurrentID = ValueState<UInt>(0)

    var body: some View {
        VStack (spacing: 0) {
            ForEach(self.messages.value.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }), id: \.key) { id, item in
                VStack(spacing: 0) {
                    Text(NSLocalizedString(item.message.title, comment: ""))
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(13)
                        .frame(maxWidth: .infinity)
                        .background(item.message.type.colorTitleBackground)
                    if (!item.message.description.isEmpty) {
                        Text(NSLocalizedString(item.message.description, comment: ""))
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(item.message.type.colorDescriptionBackground)
                    }
                }
                .foregroundPolyfill(Color.messageBox.text)
                .frame(maxWidth: .infinity)
            }
        }
    }

    func insert(type: MessageType, title: String, description: String = "", lifeTime: Message.LifeTime = .time(Message.LIFE_TIME)) {
        let message = Message(type: type, title: title, description: description)
        for current in self.messages.value {
            if (message == current.value.message) {
                return
            }
        }

        self.messageCurrentID.value += 1
        let id = self.messageCurrentID.value

        switch lifeTime {
            case .infinity:
                self.messages.value[id] = (
                    message: message,
                    expirationTimer: nil
                )
            case .time(let time):
                self.messages.value[id] = (
                    message: message,
                    expirationTimer: Timer.Custom(
                        tag: id,
                        repeats: .count(1),
                        delay: time,
                        onExpire: { _ in
                            self.messages.value[id] = nil
                        }
                    )
                )
        }
    }

}

#Preview {
    let messageBox: MessageBox = {
        let result = MessageBox()
            result.insert(type: .info   , title: "Info"   , lifeTime: .infinity)
            result.insert(type: .ok     , title: "Ok"     , lifeTime: .infinity)
            result.insert(type: .warning, title: "Warning", lifeTime: .infinity)
            result.insert(type: .error  , title: "Error"  , lifeTime: .infinity)
            result.insert(type: .info   , title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", lifeTime: .time(3))
            result.insert(type: .ok     , title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", lifeTime: .time(4))
            result.insert(type: .warning, title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", lifeTime: .time(5))
            result.insert(type: .error  , title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", lifeTime: .time(6))
        return result
    }()
    ScrollView {
        messageBox
    }
    .frame(maxWidth: 300)
    .padding(10)
}
