
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MessageBox: View {

    enum LifeTime {
        case time(Double)
        case infinity
    }

    static let LIFE_TIME_DEFAULT: CFTimeInterval = 3.0

    @ObservedObject private var state = MessageBoxState()
    @ObservedObject private var progress = MessageBoxProgressState()

    var timer: Timer.Custom!

    var sortedMessages: [(key: UInt, value: Message)] {
        self.state.messages.sorted(by: { (lhs, rhs) in
            lhs.key < rhs.key
        })
    }

    init() {
        self.timer = Timer.Custom(repeats: .infinity, delay: 0.5, onTick: self.onTimerTick)
    }

    func onTimerTick(timer: Timer.Custom) {
        for (ID, message) in self.state.messages {
            self.progress.progress[ID] = message.progress
            if (message.isExpired) {
                self.state.messages[ID] = nil
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0) {
                ForEach(self.sortedMessages, id: \.key) { ID, message in
                    VStack(alignment: .leading, spacing: 0) {

                        Text(message.title)
                            .font(.system(size: 14, weight: .bold))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .foregroundPolyfill(Color.messageBox.text)
                            .background(message.type.colorTitleBackground)

                        if (!message.description.isEmpty) {
                            Text(message.description)
                                .font(.system(size: 13))
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(13)
                                .frame(maxWidth: .infinity)
                                .foregroundPolyfill(Color.messageBox.text)
                                .background(message.type.colorDescriptionBackground)
                        }

                        if let _ = message.expiresAt {
                            Color.black.opacity(0.3)
                                .frame(width: geometry.size.width * (self.progress.progress[ID] ?? 0), height: 3)
                                .padding(.top, -3)
                        }

                    }
                }
            }
        }
    }

    public func insert(
        type: MessageType,
        title: String,
        description: String = "",
        lifeTime: Self.LifeTime = .time(Self.LIFE_TIME_DEFAULT)
    ) {
        switch lifeTime {
            case .time(let time): self.state.insert(type: type, title: title, description: description, expiresAt: CACurrentMediaTime() + time)
            case .infinity      : self.state.insert(type: type, title: title, description: description)
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    let loremIpsum = NSLocalizedString("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", comment: "")
    let messageBox: MessageBox = {
        let box = MessageBox()
            box.insert(type: .info   , title: NSLocalizedString("Info"   , comment: ""), lifeTime: .infinity)
            box.insert(type: .ok     , title: NSLocalizedString("Ok"     , comment: ""), lifeTime: .infinity)
            box.insert(type: .warning, title: NSLocalizedString("Warning", comment: ""), lifeTime: .infinity)
            box.insert(type: .error  , title: NSLocalizedString("Error"  , comment: ""), lifeTime: .infinity)
            box.insert(type: .info   , title: loremIpsum, description: loremIpsum, lifeTime: .time(3))
            box.insert(type: .ok     , title: loremIpsum, description: loremIpsum, lifeTime: .time(4))
            box.insert(type: .warning, title: loremIpsum, description: loremIpsum, lifeTime: .time(5))
            box.insert(type: .error  , title: loremIpsum, description: loremIpsum, lifeTime: .time(6))
        return box
    }()
    ScrollView {
        messageBox
    }.frame(maxWidth: 300)
}
