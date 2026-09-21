
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public static let MESSAGE_BOX_MAIN_ID: MessageBoxID = 0

    public static let DEMO_LONG_TITLE       = NSLocalizedString("Long long long long long long long long long long long long long long Title", comment: "")
    public static let DEMO_LONG_DESCRIPTION = NSLocalizedString("Long long long long long long long long long long long long long long long long long long long long long Description", comment: "")

    var body: some Scene {
        let window = WindowGroup {
            self.mainSceneView()
                .environment(\.layoutDirection, .leftToRight)
        }
        if #available(macOS 13.0, *) { return window.windowResizability(.contentSize) }
        else                         { return window }
    }

    @ViewBuilder fileprivate func mainSceneView() -> some View {
        HStack (spacing: 10) {

            VStack(spacing: 10) {
                Text("3 (default) sec.").font(.headline)
                self.ButtonInsertMessageView(text:    "Info Message"         , type: .info   , title:    "Info Message")
                self.ButtonInsertMessageView(text:      "Ok Message"         , type: .ok     , title:      "Ok Message")
                self.ButtonInsertMessageView(text: "Warning Message"         , type: .warning, title: "Warning Message")
                self.ButtonInsertMessageView(text:   "Error Message"         , type: .error  , title:   "Error Message")
                self.ButtonInsertMessageView(text:    "Info Message + Descr.", type: .info   , title:    "Info Message", description: Self.DEMO_LONG_DESCRIPTION)
                self.ButtonInsertMessageView(text:      "Ok Message + Descr.", type: .ok     , title:      "Ok Message", description: Self.DEMO_LONG_DESCRIPTION)
                self.ButtonInsertMessageView(text: "Warning Message + Descr.", type: .warning, title: "Warning Message", description: Self.DEMO_LONG_DESCRIPTION)
                self.ButtonInsertMessageView(text:   "Error Message + Descr.", type: .error  , title:   "Error Message", description: Self.DEMO_LONG_DESCRIPTION)
            }

            ScrollView {
                MessageBox(
                    ID: Self.MESSAGE_BOX_MAIN_ID
                )
            }

        }
        .padding(10)
        .frame(minWidth: 500)
    }

    @ViewBuilder private func ButtonInsertMessageView(text: String, type: MessageType, title: String? = nil, description: String? = nil) -> some View {
        Button {
            MessageBox.insert(to: Self.MESSAGE_BOX_MAIN_ID, .init(
                type: type,
                lifetime: .time(duration: 3.0),
                isClosable: false,
                title: title,
                description: description
            ))
        } label: {
            Text(text).frame(width: 200)
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    ThisApp().mainSceneView()
}
