
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public static let DEMO_LONG_TITLE       = NSLocalizedString("Long long long long long long long long long long long long long long Title", comment: "")
    public static let DEMO_LONG_DESCRIPTION = NSLocalizedString("Long long long long long long long long long long long long long long long long long long long long long Description", comment: "")

    enum MergePolicy: Codable, CaseIterable, Hashable {

        case replaceOrInsertAtTop
        case replaceOrInsertAtBottom
        case deleteAndInsertAtTop
        case deleteAndInsertAtBottom

        var title: String {
            switch self {
                case .replaceOrInsertAtTop   : "Replace Or Insert At Top"
                case .replaceOrInsertAtBottom: "Replace Or Insert At Bottom"
                case .deleteAndInsertAtTop   : "Delete And Insert At Top"
                case .deleteAndInsertAtBottom: "Delete And Insert At Bottom"
            }
        }

        var messageMergePolicy: MessageMergePolicy {
            switch self {
                case .replaceOrInsertAtTop   : .replaceOrInsertAtTop
                case .replaceOrInsertAtBottom: .replaceOrInsertAtBottom
                case .deleteAndInsertAtTop   : .deleteAndInsertAtTop
                case .deleteAndInsertAtBottom: .deleteAndInsertAtBottom
            }
        }

    }

    @State private var mergePolicy: MergePolicy = .replaceOrInsertAtBottom

    public static let messageBoxMainAddress: MessageBoxAddress = .local(
        boxID: MessageBoxID(0)
    )

    private let columns = [
        GridItem(.fixed(200), spacing: 10, alignment: .bottom),
        GridItem(.fixed(200), spacing: 10, alignment: .bottom),
        GridItem(.flexible(), alignment: .top),
    ]

    var body: some Scene {
        let window = WindowGroup {
            self.mainSceneView()
                .environment(\.layoutDirection, .leftToRight)
        }
        if #available(macOS 13.0, *) { return window.windowResizability(.contentSize) }
        else                         { return window }
    }

    @ViewBuilder fileprivate func mainSceneView() -> some View {
        VStack(spacing: 10) {

            LazyVGrid(columns: columns, spacing: 0) {

                VStack(spacing: 10) {
                    Text("lifetime: 10 sec.").font(.headline)
                    self.ButtonInsertMessageView(   "Info Message"         , type: .info   , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title:    "Info Message")
                    self.ButtonInsertMessageView(     "Ok Message"         , type: .ok     , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title:      "Ok Message")
                    self.ButtonInsertMessageView("Warning Message"         , type: .warning, lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: "Warning Message")
                    self.ButtonInsertMessageView(  "Error Message"         , type: .error  , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title:   "Error Message")
                    self.ButtonInsertMessageView(   "Info Message + Descr.", type: .info   , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                    self.ButtonInsertMessageView(     "Ok Message + Descr.", type: .ok     , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                    self.ButtonInsertMessageView("Warning Message + Descr.", type: .warning, lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                    self.ButtonInsertMessageView(  "Error Message + Descr.", type: .error  , lifetime: .time(duration: 10.0), isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                }

                VStack(spacing: 10) {
                    Text("lifetime: infinity").font(.headline)
                    self.ButtonInsertMessageView(   "Info Message"         , type: .info   , lifetime: .infinity, isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title:    "Info Message")
                    self.ButtonInsertMessageView(     "Ok Message"         , type: .ok     , lifetime: .infinity, isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title:      "Ok Message")
                    self.ButtonInsertMessageView("Warning Message"         , type: .warning, lifetime: .infinity, isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: "Warning Message")
                    self.ButtonInsertMessageView(  "Error Message"         , type: .error  , lifetime: .infinity, isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title:   "Error Message")
                    self.ButtonInsertMessageView(   "Info Message + Descr.", type: .info   , lifetime: .infinity, isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                    self.ButtonInsertMessageView(     "Ok Message + Descr.", type: .ok     , lifetime: .infinity, isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                    self.ButtonInsertMessageView("Warning Message + Descr.", type: .warning, lifetime: .infinity, isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                    self.ButtonInsertMessageView(  "Error Message + Descr.", type: .error  , lifetime: .infinity, isClosable: true, mergePolicy: self.mergePolicy.messageMergePolicy, title: Self.DEMO_LONG_TITLE, description: Self.DEMO_LONG_DESCRIPTION)
                }

                ScrollView {
                    MessageBox(
                        address: Self.messageBoxMainAddress
                    )
                }
                .frame(height: 280)
                .background(Color.white)

            }

            Picker("Merge Policy", selection: self.$mergePolicy) {
                ForEach(MergePolicy.allCases, id: \.self) { value in
                    Text("\(value.title)").tag(value)
                }
            }.frame(width: 300)

        }
        .padding(10)
        .frame(minWidth: 600)
        .frame(maxWidth: 800)
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
            MessageBox.insert(address: Self.messageBoxMainAddress, .init(
                type: type,
                lifetime: lifetime,
                isClosable: isClosable,
                mergePolicy: mergePolicy,
                title: title,
                description: description
            ))
        } label: {
            Text(text)
                .frame(maxWidth: .infinity)
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    ThisApp().mainSceneView()
}
