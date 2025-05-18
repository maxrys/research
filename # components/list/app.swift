
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    enum listVariants {
        case listItem1
        case listItem2
        case listItem3
    }

    @State private var textFieldValue: String = ""
    @State private var isChecked: Bool = true
    @State private var sliderValue: CGFloat = 5
    @State private var listSelection: listVariants = .listItem1
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
                        TextField("Text field", text: self.$textFieldValue)
                        Toggle("Checkbox", isOn: self.$isChecked)
                        Slider(value: self.$sliderValue, in: 1 ... 10) {
                            Label("Slider", systemImage: "text.magnifyingglass")
                        }
                        Picker("List", selection: self.$listSelection) {
                            Text("listItem1").tag(listVariants.listItem1)
                            Text("listItem2").tag(listVariants.listItem2)
                            Text("listItem3").tag(listVariants.listItem3)
                        }
                        Button { } label: {
                            Text("Do something")
                        }
                    } header: { Text("Form Elements") }

                    Section {
                        ForEach(self.goods.sorted(), id: \.self) { value in
                            Text(value)
                        }
                    } header: {
                        Text("ForEach")
                    } footer: {
                        Text("Some description.")
                    }

                    Section {
                        DisclosureGroup("Group") {
                            ForEach(self.goods.sorted(), id: \.self) { value in
                                Text(value)
                            }
                        }
                    } header: {
                        Text("ForEach")
                    } footer: {
                        Text("Some description.")
                    }

                }

            }
        }
    }

    init() {

    }

}
