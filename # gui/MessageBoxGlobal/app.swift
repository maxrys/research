
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

    init() {
        EventsDispatcher.shared.on(MessageBox.EVENT_NAME_FOR_MESSAGE_INSERT) { _ in
            print("message: messageInsert")
        }
    }

    @ViewBuilder func buttonInsert(text: String, type: MessageType, title: String, description: String = "") -> some View {
        Button {
            MessageBox.insert(
                type: type,
                title: title,
                description: description
            )
        } label: {
            Text(text).frame(maxWidth: .infinity)
        }
    }

    @ViewBuilder var mainScene: some View {
        HStack(spacing: 0) {

            /* MARK: buttons */
            VStack(spacing: 10) {
                self.buttonInsert(text: "Send Info Message"            , type: .info   , title:    "Info message")
                self.buttonInsert(text: "Send Ok Message"              , type: .ok     , title:      "Ok message")
                self.buttonInsert(text: "Send Warning Message"         , type: .warning, title: "Warning message")
                self.buttonInsert(text: "Send Error Message"           , type: .error  , title:   "Error message")
                self.buttonInsert(text: "Send Info Message + Descr."   , type: .info   , title:    "Info message", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                self.buttonInsert(text: "Send Ok Message + Descr."     , type: .ok     , title:      "Ok message", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                self.buttonInsert(text: "Send Warning Message + Descr.", type: .warning, title: "Warning message", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                self.buttonInsert(text: "Send Error Message + Descr."  , type: .error  , title:   "Error message", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            }
            .padding(10)
            .frame(maxWidth: 240, maxHeight: .infinity)
            .background(Color.gray)

            /* MARK: message box */
            HStack(spacing: 10) {
                ScrollView(.vertical) { MessageBox() }
                ScrollView(.vertical) { MessageBox() }
            }
            .padding(10)
            .frame(maxWidth: 300, maxHeight: .infinity, alignment: .top)

        }
    }

}

#Preview {
    ThisApp().mainScene
}
