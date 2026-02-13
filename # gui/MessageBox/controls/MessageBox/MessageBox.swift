
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

    var body: some View {
        VStack (spacing: 0) {
            ForEach(self.state.messages.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }), id: \.key) { ID, message in
                VStack(spacing: 0) {

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
