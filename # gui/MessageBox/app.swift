
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        let window = WindowGroup {
            self.mainScene
                .environment(\.layoutDirection, .leftToRight)
        }
        if #available(macOS 13.0, *) { return window.windowResizability(.contentSize) }
        else                         { return window }
    }

    let messageBox = MessageBox()

    @ViewBuilder var mainScene: some View {
        HStack(spacing: 0) {

            let longTitle       = NSLocalizedString("Long long long long long long long long long long long long long long Title", comment: "")
            let longDescription = NSLocalizedString("Long long long long long long long long long long long long long long long long long long long long long Description", comment: "")

            /* MARK: buttons */
            VStack(spacing: 10) {

                Text("3 (default) sec.").font(.headline)
                self.ButtonInsert(text:    "Info Message"         , type: .info   , title:    "Info Message")
                self.ButtonInsert(text:      "Ok Message"         , type: .ok     , title:      "Ok Message")
                self.ButtonInsert(text: "Warning Message"         , type: .warning, title: "Warning Message")
                self.ButtonInsert(text:   "Error Message"         , type: .error  , title:   "Error Message")
                self.ButtonInsert(text:    "Info Message + Descr.", type: .info   , title:    "Info Message", description: longDescription)
                self.ButtonInsert(text:      "Ok Message + Descr.", type: .ok     , title:      "Ok Message", description: longDescription)
                self.ButtonInsert(text: "Warning Message + Descr.", type: .warning, title: "Warning Message", description: longDescription)
                self.ButtonInsert(text:   "Error Message + Descr.", type: .error  , title:   "Error Message", description: longDescription)

                Text("10 sec.").font(.headline)
                self.ButtonInsert(text:    "Info Message"         , type: .info   , title:    "Info Message",                               lifeTime: .time(10))
                self.ButtonInsert(text:      "Ok Message"         , type: .ok     , title:      "Ok Message",                               lifeTime: .time(10))
                self.ButtonInsert(text: "Warning Message"         , type: .warning, title: "Warning Message",                               lifeTime: .time(10))
                self.ButtonInsert(text:   "Error Message"         , type: .error  , title:   "Error Message",                               lifeTime: .time(10))
                self.ButtonInsert(text:    "Info Message + Descr.", type: .info   , title:    "Info Message", description: longDescription, lifeTime: .time(10))
                self.ButtonInsert(text:      "Ok Message + Descr.", type: .ok     , title:      "Ok Message", description: longDescription, lifeTime: .time(10))
                self.ButtonInsert(text: "Warning Message + Descr.", type: .warning, title: "Warning Message", description: longDescription, lifeTime: .time(10))
                self.ButtonInsert(text:   "Error Message + Descr.", type: .error  , title:   "Error Message", description: longDescription, lifeTime: .time(10))

                Text("Infinity sec.").font(.headline)
                self.ButtonInsert(text:    "Info Message"         , type: .info   , title: longTitle,                               isClosable: true, lifeTime: .infinity)
                self.ButtonInsert(text:      "Ok Message"         , type: .ok     , title: longTitle,                               isClosable: true, lifeTime: .infinity)
                self.ButtonInsert(text: "Warning Message"         , type: .warning, title: longTitle,                               isClosable: true, lifeTime: .infinity)
                self.ButtonInsert(text:   "Error Message"         , type: .error  , title: longTitle,                               isClosable: true, lifeTime: .infinity)
                self.ButtonInsert(text:    "Info Message + Descr.", type: .info   , title: longTitle, description: longDescription, isClosable: true, lifeTime: .infinity)
                self.ButtonInsert(text:      "Ok Message + Descr.", type: .ok     , title: longTitle, description: longDescription, isClosable: true, lifeTime: .infinity)
                self.ButtonInsert(text: "Warning Message + Descr.", type: .warning, title: longTitle, description: longDescription, isClosable: true, lifeTime: .infinity)
                self.ButtonInsert(text:   "Error Message + Descr.", type: .error  , title: longTitle, description: longDescription, isClosable: true, lifeTime: .infinity)

            }
            .padding(10)
            .frame(maxWidth: 240, maxHeight: .infinity)
            .background(Color.gray)

            /* MARK: message box */
            HStack(spacing: 10) {
                self.messageBox
            }
            .padding(10)
            .frame(maxWidth: 300, maxHeight: .infinity, alignment: .top)

        }
    }

    @ViewBuilder func ButtonInsert(
        text: String,
        type: MessageType,
        title: String,
        description: String = "",
        isClosable: Bool = false,
        lifeTime: MessageBox.LifeTime = .time(MessageBox.LIFE_TIME_DEFAULT)
    ) -> some View {
        Button {
            self.messageBox.insert(
                type: type,
                title: title,
                description: description,
                isClosable: isClosable,
                lifeTime: lifeTime
            )
        } label: {
            Text(text).frame(maxWidth: .infinity)
        }
    }

}

#Preview {
    ThisApp().mainScene
}
