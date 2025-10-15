
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
                    PickerCustomColored<UInt>(selected: $selected, values: values)
                    PickerCustomColored<UInt>(selected: $selected, values: values, flexibility: .none)
                    PickerCustomColored<UInt>(selected: $selected, values: values, flexibility: .size(100))
                    PickerCustomColored<UInt>(selected: $selected, values: values, flexibility: .infinity)
                }

                VStack {
                    PickerCustom<UInt>(selected: $selected, values: values)
                    PickerCustom<UInt>(selected: $selected, values: values, flexibility: .none)
                    PickerCustom<UInt>(selected: $selected, values: values, flexibility: .size(100))
                    PickerCustom<UInt>(selected: $selected, values: values, flexibility: .infinity)
                }

            }.padding(30)
        }
    }

    init() {

    }

}
