
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
                self.ButtonInsertMessageView(   "Info Message"         , type: .info   , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: .replaceOrInsert, title:    "Info Message")
                self.ButtonInsertMessageView(     "Ok Message"         , type: .ok     , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: .replaceOrInsert, title:      "Ok Message")
                self.ButtonInsertMessageView("Warning Message"         , type: .warning, lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: .replaceOrInsert, title: "Warning Message")
                self.ButtonInsertMessageView(  "Error Message"         , type: .error  , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: .replaceOrInsert, title:   "Error Message")
                self.ButtonInsertMessageView(   "Info Message + Descr.", type: .info   , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: .replaceOrInsert, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                self.ButtonInsertMessageView(     "Ok Message + Descr.", type: .ok     , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: .replaceOrInsert, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                self.ButtonInsertMessageView("Warning Message + Descr.", type: .warning, lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: .replaceOrInsert, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                self.ButtonInsertMessageView(  "Error Message + Descr.", type: .error  , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: .replaceOrInsert, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
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

    @ViewBuilder private func ButtonInsertMessageView(
        _ text: String,
        type: MessageType,
        lifetime: MessageLifeTime,
        isClosable: Bool,
        mergePolicy: MessageMergePolicy,
        title: String,
        description: String? = nil
    ) -> some View {
        Button {
            MessageBox.insert(to: Self.MESSAGE_BOX_MAIN_ID, .init(
                type: type,
                lifetime: lifetime,
                isClosable: isClosable,
                mergePolicy: mergePolicy,
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
