
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    enum AppearanceStyle {
        case dark, light, auto
    }

    @State var username: String = "Max"
    @State var isPrivate: Bool = true
    @State private var fontSize: CGFloat = 5
    @State private var appearance: AppearanceStyle = .auto
    @State private var goods = [
        "item 1",
        "item 2",
        "item 3",
    ]

    var body: some Scene {
        WindowGroup {
            VStack {

                List {
                    Section {
                        TextField("Username", text: $username)
                        Toggle("Private Account", isOn: $isPrivate)
                        Button { } label: {
                            Text("Sign out")
                        }
                    } header: { Text("Profile") }

                    Section {
                        Slider(value: $fontSize, in: 1 ... 10) {
                            Label("Default Font Size", systemImage: "text.magnifyingglass")
                        }
                        Picker("Appearance", selection: $appearance) {
                            Text("Dark" ).tag(AppearanceStyle.dark)
                            Text("Light").tag(AppearanceStyle.light)
                            Text("Auto" ).tag(AppearanceStyle.auto)
                        }
                    } header: { Text("Appearance") }

                    Section {
                        HStack {
                            Text("Key")
                            Spacer()
                            Text("Value")
                        }
                    } header: { Text("About") }

                    Section {
                        ForEach(self.goods.sorted(), id: \.self) { value in
                            Text(value)
                        }
                    } header: { Text("ForEach") }

                }

            }
        }
    }

    init() {

    }

}
