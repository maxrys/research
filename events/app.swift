
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    static let dispatcher = EventsDispatcher.shared

    var body: some Scene {
        WindowGroup {
            self.mainScene
        }.windowResizability(.contentSize)
    }

    init() {
        Self.dispatcher.on("messageInsert") { _ in print("messageInsert") }
        Self.dispatcher.on("messageDelete") { _ in print("messageDelete") }
    }

    @ViewBuilder func buttonInsert(title: String, type: MessageType, text: String) -> some View {
        Button {
            Self.dispatcher.send(
                "messageInsert",
                object: Message(
                    type: type,
                    text: text
                )
            )
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
        }
    }

    @ViewBuilder func buttonDelete() -> some View {
        Button {
            Self.dispatcher.send("messageDelete", object: [])
        } label: {
            Text("delete all")
        }
    }

    @ViewBuilder var mainScene: some View {
        HStack(spacing: 0) {

            /* MARK: buttons */
            VStack(spacing: 10) {
                self.buttonInsert(title: "Send Info Message"   , type: .info   , text: "Info message.")
                self.buttonInsert(title: "Send Ok Message"     , type: .ok     , text: "Ok message.")
                self.buttonInsert(title: "Send Warning Message", type: .warning, text: "Warning message!")
                self.buttonInsert(title: "Send Error Message"  , type: .error  , text: "Error message!")
                self.buttonDelete()
            }
            .padding(10)
            .frame(maxWidth: 200, maxHeight: .infinity)
            .background(.gray)

            /* MARK: message box */
            VStack(spacing: 10) {
                ScrollView {
                    MessageBox()
                }
            }
            .padding(10)
            .frame(maxWidth: 200, maxHeight: .infinity, alignment: .top)

        }
    }

}

#Preview {
    app().mainScene
}
