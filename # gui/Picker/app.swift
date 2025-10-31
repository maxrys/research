
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let NA_SIGN = "—"

    @State var selectedInt: UInt = 0
    @State var selectedString: String = ""

    let itemsInt0: [UInt: String] = [:]

    let itemsInt10 = {
        (1000 ..< 1010).reduce(into: [UInt: String]()) { result, i in
            if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else        { result[UInt(i)] = "Value \(i)" }
        }
    }()

    let itemsInt100 = {
        (1000 ..< 1100).reduce(into: [UInt: String]()) { result, i in
            if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else        { result[UInt(i)] = "Value \(i)" }
        }
    }()

    let itemsString100 = {
        (1000 ..< 1100).reduce(into: [String: String]()) { result, i in
            if (i == 5) { result["id:\(i)"] = "Value \(i) long long long long long long" }
            else        { result["id:\(i)"] = "Value \(i)" }
        }
    }()

    var body: some Scene {
        WindowGroup {
            HStack(spacing: 20) {

                VStack(spacing: 20) {
                    Text("PickerCustom").font(.headline)

                    VStack {
                        Text("0 values")
                        PickerCustom<UInt>(selected: self.$selectedInt, items: self.itemsInt0)
                    }

                    VStack {
                        Text("10 values")
                        PickerCustom<UInt>(selected: self.$selectedInt, items: self.itemsInt10)
                    }

                    VStack {
                        Text("100 values + flexibility")
                        PickerCustom<UInt>(selected: self.$selectedInt, items: self.itemsInt100)
                        PickerCustom<UInt>(selected: self.$selectedInt, items: self.itemsInt100, flexibility: .none)
                        PickerCustom<UInt>(selected: self.$selectedInt, items: self.itemsInt100, flexibility: .size(100))
                        PickerCustom<UInt>(selected: self.$selectedInt, items: self.itemsInt100, flexibility: .infinity)
                    }

                    VStack {
                        Text("String values")
                        PickerCustom<String>(
                            selected: self.$selectedString,
                            items: self.itemsString100
                        )
                    }
                }

                VStack {
                    Text("Picker").font(.headline)
                    Picker("", selection: self.$selectedInt) {
                        ForEach(self.itemsInt100.ordered(), id: \.key) { key, value in
                            Text(value)
                        }
                    }
                }

            }.padding(30)
        }
    }

    init() {

    }

}
