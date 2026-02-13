
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MessageBox: View {

    typealias MessageCollection = [
        UInt: (
            message: Message,
            expirationTimer: Timer.Custom?
        )
    ]

    static let LIFE_TIME_DEFAULT: Double = 3.0

    @ObservedObject private var messages = ValueState<MessageCollection>([:])
    @ObservedObject private var messageCurrentID = ValueState<UInt>(0)

    var body: some View {
        VStack (spacing: 0) {
            ForEach(self.messages.value.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }), id: \.key) { id, item in
                VStack(spacing: 0) {

                    Text(item.message.title)
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(13)
                        .frame(maxWidth: .infinity)
                        .foregroundPolyfill(Color.messageBox.text)
                        .background(item.message.type.colorTitleBackground)

                    if (!item.message.description.isEmpty) {
                        Text(item.message.description)
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .foregroundPolyfill(Color.messageBox.text)
                            .background(item.message.type.colorDescriptionBackground)
                    }

                }
            }
        }
    }

    func insert(
        type: MessageType,
        title: String,
        description: String = "",
        lifeTime: Message.LifeTime = .time(Self.LIFE_TIME_DEFAULT)
    ) {

        let message = Message(
            type: type,
            title: title,
            description: description
        )

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
    let loremIpsum = NSLocalizedString("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", comment: "")
    let messageBox: MessageBox = {
        let result = MessageBox()
            result.insert(type: .info   , title: NSLocalizedString("Info"   , comment: ""), lifeTime: .infinity)
            result.insert(type: .ok     , title: NSLocalizedString("Ok"     , comment: ""), lifeTime: .infinity)
            result.insert(type: .warning, title: NSLocalizedString("Warning", comment: ""), lifeTime: .infinity)
            result.insert(type: .error  , title: NSLocalizedString("Error"  , comment: ""), lifeTime: .infinity)
            result.insert(type: .info   , title: loremIpsum, description: loremIpsum, lifeTime: .time(3))
            result.insert(type: .ok     , title: loremIpsum, description: loremIpsum, lifeTime: .time(4))
            result.insert(type: .warning, title: loremIpsum, description: loremIpsum, lifeTime: .time(5))
            result.insert(type: .error  , title: loremIpsum, description: loremIpsum, lifeTime: .time(6))
        return result
    }()
    ScrollView {
        messageBox
    }.frame(maxWidth: 300)
}
