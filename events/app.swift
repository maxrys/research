
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
        Self.dispatcher.on("onShowMessage") { event in
            #if DEBUG
                print(event.data)
            #endif
        }
    }

    @ViewBuilder func button(title: String, type: String, message: String) -> some View {
        Button {
            Self.dispatcher.send(
                "onShowMessage",
                message: Event(
                    name: type,
                    data: message
                )
            )
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
        }
    }

    @ViewBuilder var mainScene: some View {
        HStack(spacing: 0) {

            /* MARK: buttons */
            VStack(spacing: 10) {
                self.button(title: "Send Info Message"   , type: "info"   , message: "This is an Info message.")
                self.button(title: "Send Ok Message"     , type: "ok"     , message: "This is an Ok message.")
                self.button(title: "Send Warning Message", type: "warning", message: "This is an Warning message.")
                self.button(title: "Send Error Message"  , type: "error"  , message: "This is an Error message.")
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
