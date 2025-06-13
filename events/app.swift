
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    static let dispatcher = EventsDispatcher.shared

    var body: some Scene {
        WindowGroup {
            self.mainScene
        }
    }

    init() {
    }

    @ViewBuilder var mainScene: some View {

        /* MARK: message box */
        MessageBox()

        VStack(spacing: 10) {
            /* MARK: message:ok */
            Button {
                Self.dispatcher.send(
                    "onShowMessage",
                    message: Event(
                        name: "ok",
                        data: "This is an Ok message."
                    )
                )
            } label: {
                Text("Send Ok Message")
                    .frame(maxWidth: .infinity)
            }

            /* MARK: message:warning */
            Button {
                Self.dispatcher.send(
                    "onShowMessage",
                    message: Event(
                        name: "warning",
                        data: "This is a Warning message!"
                    )
                )
            } label: {
                Text("Send Warning Message")
                    .frame(maxWidth: .infinity)
            }

            /* MARK: message:alert */
            Button {
                Self.dispatcher.send(
                    "onShowMessage",
                    message: Event(
                        name: "alert",
                        data: "This is an Alert message!"
                    )
                )
            } label: {
                Text("Send Alert Message")
                    .frame(maxWidth: .infinity)
            }
        }.frame(width: 200)

    }

}

#Preview {
    app().mainScene
        .padding(10)
}
