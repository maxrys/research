
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
                self.ButtonInsertMessageView(   "Info Message"         , .init(type: .info   , lifetime: .time(duration: 10.0), isClosable: false, title:    "Info Message"))
                self.ButtonInsertMessageView(     "Ok Message"         , .init(type: .ok     , lifetime: .time(duration: 10.0), isClosable: false, title:      "Ok Message"))
                self.ButtonInsertMessageView("Warning Message"         , .init(type: .warning, lifetime: .time(duration: 10.0), isClosable: false, title: "Warning Message"))
                self.ButtonInsertMessageView(  "Error Message"         , .init(type: .error  , lifetime: .time(duration: 10.0), isClosable: false, title:   "Error Message"))
                self.ButtonInsertMessageView(   "Info Message + Descr.", .init(type: .info   , lifetime: .time(duration: 10.0), isClosable: false, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION))
                self.ButtonInsertMessageView(     "Ok Message + Descr.", .init(type: .ok     , lifetime: .time(duration: 10.0), isClosable: false, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION))
                self.ButtonInsertMessageView("Warning Message + Descr.", .init(type: .warning, lifetime: .time(duration: 10.0), isClosable: false, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION))
                self.ButtonInsertMessageView(  "Error Message + Descr.", .init(type: .error  , lifetime: .time(duration: 10.0), isClosable: false, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION))
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

    @ViewBuilder private func ButtonInsertMessageView(_ text: String, _ messageInfo: MessageInfo) -> some View {
        Button {
            MessageBox.insert(to: Self.MESSAGE_BOX_MAIN_ID, messageInfo)
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
