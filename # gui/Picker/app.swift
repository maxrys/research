
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let NA_SIGN = "—"

    @State var selected: UInt = 0

    let values = {
        (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
            if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else        { result[UInt(i)] = "Value \(i)" }
        }
    }()

    var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {

                VStack {
                    Text("Picker").font(.headline)
                    Picker("", selection: self.$selected) {
                        ForEach(self.values.ordered(), id: \.key) { key, value in
                            Text(value)
                        }
                    }
                }

                VStack {
                    Text("PickerCustom").font(.headline)
                    PickerCustom<UInt>(selected: self.$selected, values: self.values)
                    PickerCustom<UInt>(selected: self.$selected, values: self.values, flexibility: .none)
                    PickerCustom<UInt>(selected: self.$selected, values: self.values, flexibility: .size(100))
                    PickerCustom<UInt>(selected: self.$selected, values: self.values, flexibility: .infinity)
                }

                if #available(macOS 14.0, *) {
                    VStack {
                        Text("PickerExtended").font(.headline)
                        PickerExtended<UInt>(selected: self.$selected, values: self.values)
                        PickerExtended<UInt>(selected: self.$selected, values: self.values, flexibility: .none)
                        PickerExtended<UInt>(selected: self.$selected, values: self.values, flexibility: .size(100))
                        PickerExtended<UInt>(selected: self.$selected, values: self.values, flexibility: .infinity)
                    }
                }

                VStack {
                    Text("PickerCustomSimple").font(.headline)
                    PickerCustomSimple<UInt>(selected: self.$selected, values: self.values)
                    PickerCustomSimple<UInt>(selected: self.$selected, values: self.values, flexibility: .none)
                    PickerCustomSimple<UInt>(selected: self.$selected, values: self.values, flexibility: .size(100))
                    PickerCustomSimple<UInt>(selected: self.$selected, values: self.values, flexibility: .infinity)
                }

            }.padding(30)
        }
    }

    init() {

    }

}
