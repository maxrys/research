
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    var body: some Scene {
        WindowGroup {
            self.mainScene
        }.windowResizability(.contentSize)
    }

    init() {
        EventsDispatcher.shared.on("messageInsert") { _ in print("messageInsert 1") }
        EventsDispatcher.shared.on("messageInsert") { _ in print("messageInsert 2") }
        EventsDispatcher.shared.on("messageDelete") { _ in print("messageDelete 1") }
        EventsDispatcher.shared.on("messageDelete") { _ in print("messageDelete 2") }
    }

    @ViewBuilder func buttonInsert(text: String, type: MessageType, title: String, description: String = "") -> some View {
        Button {
            MessageBox.send(type: type, title: title, description: description)
        } label: {
            Text(text).frame(maxWidth: .infinity)
        }
    }

    @ViewBuilder func buttonDelete(text: String) -> some View {
        Button {
            MessageBox.deleteAll()
        } label: {
            Text(text)
        }
    }

    @ViewBuilder var mainScene: some View {
        HStack(spacing: 0) {

            /* MARK: buttons */
            VStack(spacing: 10) {
                self.buttonInsert(text: "Send Info Message"            , type: .info   , title: "Info message")
                self.buttonInsert(text: "Send Ok Message"              , type: .ok     , title: "Ok message")
                self.buttonInsert(text: "Send Warning Message"         , type: .warning, title: "Warning message")
                self.buttonInsert(text: "Send Error Message"           , type: .error  , title: "Error message")
                self.buttonInsert(text: "Send Info Message + Descr."   , type: .info   , title: "Info message"   , description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                self.buttonInsert(text: "Send Ok Message + Descr."     , type: .ok     , title: "Ok message"     , description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                self.buttonInsert(text: "Send Warning Message + Descr.", type: .warning, title: "Warning message", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                self.buttonInsert(text: "Send Error Message + Descr."  , type: .error  , title: "Error message"  , description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                self.buttonDelete(text: "delete all")
            }
            .padding(10)
            .frame(maxWidth: 240, maxHeight: .infinity)
            .background(.gray)

            /* MARK: message box 1 */
            VStack(spacing: 10) {
                ScrollView {
                    MessageBox()
                }
            }
            .padding(10)
            .frame(maxWidth: 200, maxHeight: .infinity, alignment: .top)

            /* MARK: message box 2 */
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
