
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct MessageBox: View {

    enum LifeTime {
        case time(Double)
        case infinity
    }

    static let LIFE_TIME_DEFAULT: CFTimeInterval = 3.0

    @ObservedObject private var state = MessageBoxState()

    var timer: Timer.Custom!

    var sortedMessages: [(key: MessageID, value: Message)] {
        self.state.messages.sorted(by: { (lhs, rhs) in
            lhs.key < rhs.key
        })
    }

    init() {
        self.timer = Timer.Custom(
            repeats: .infinity,
            delay: 0.5,
            onTick: self.onTimerTick
        )
    }

    func onTimerTick(timer: Timer.Custom) {
        Logger.customLog("Timer onTimerTick \(timer.i)")
        for (ID, message) in self.state.messages {
            if (message.isExpired) {
                   self.state.messages[ID] = nil
                   self.state.progress[ID] = nil }
            else { self.state.progress[ID] = message.progress }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0) {
                ForEach(self.sortedMessages, id: \.key) { ID, message in
                    VStack(alignment: .leading, spacing: 0) {

                        self.Title(message)
                            .overlayPolyfill(alignment: .trailing) {
                                if (message.isClosable) {
                                    self.ButtonClose(ID)
                                        .padding(.trailing, 10)
                                }
                            }

                        if (!message.description.isEmpty) {
                            self.Description(message)
                        }

                        if let _ = message.expiresAt {
                            self.Progress(width: geometry.size.width * (self.state.progress[ID] ?? 0))
                                .padding(.top, -3)
                        }

                    }
                }
            }
        }
    }

    @ViewBuilder func Title(_ message: Message) -> some View {
        Text(message.title)
            .font(.system(size: 14, weight: .bold))
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(13)
            .frame(maxWidth: .infinity)
            .foregroundPolyfill(Color.messageBox.text)
            .background(message.type.colorTitleBackground)
    }

    @ViewBuilder func Description(_ message: Message) -> some View {
        Text(message.description)
            .font(.system(size: 13))
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(13)
            .frame(maxWidth: .infinity)
            .foregroundPolyfill(Color.messageBox.text)
            .background(message.type.colorDescriptionBackground)
    }

    @ViewBuilder func Progress(width: CGFloat) -> some View {
        Color.black.opacity(0.3)
            .frame(width: width, height: 3)
    }

    @ViewBuilder func ButtonClose(_ ID: MessageID) -> some View {
        Button {
            self.state.messages[ID] = nil
            self.state.progress[ID] = nil
        } label: {
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 20, height: 20)
                .overlayPolyfill {
                    Image(systemName: "xmark")
                        .foregroundPolyfill(.white.opacity(0.5))
                }
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

    public func insert(
        type: MessageType,
        title: String,
        description: String = "",
        isClosable: Bool = false,
        lifeTime: Self.LifeTime = .time(Self.LIFE_TIME_DEFAULT)
    ) {
        switch lifeTime {
            case .time(let time): self.state.insert(type: type, title: title, description: description, isClosable: isClosable, expiresAt: CACurrentMediaTime() + time)
            case .infinity      : self.state.insert(type: type, title: title, description: description, isClosable: isClosable)
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
