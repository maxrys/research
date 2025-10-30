
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let NA_SIGN = "—"

    @State var selectedInt: UInt = 0
    @State var selectedString: String = ""

    let valuesInt0: [UInt: String] = [:]

    let valuesInt10 = {
        (0 ..< 10).reduce(into: [UInt: String]()) { result, i in
            if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else        { result[UInt(i)] = "Value \(i)" }
        }
    }()

    let valuesInt100 = {
        (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
            if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else        { result[UInt(i)] = "Value \(i)" }
        }
    }()

    let valuesString100 = {
        (0 ..< 100).reduce(into: [String: String]()) { result, i in
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
                        PickerCustom<UInt>(selected: self.$selectedInt, values: self.valuesInt0)
                    }

                    VStack {
                        Text("10 values")
                        PickerCustom<UInt>(selected: self.$selectedInt, values: self.valuesInt10)
                    }

                    VStack {
                        Text("100 values + flexibility")
                        PickerCustom<UInt>(selected: self.$selectedInt, values: self.valuesInt100)
                        PickerCustom<UInt>(selected: self.$selectedInt, values: self.valuesInt100, flexibility: .none)
                        PickerCustom<UInt>(selected: self.$selectedInt, values: self.valuesInt100, flexibility: .size(100))
                        PickerCustom<UInt>(selected: self.$selectedInt, values: self.valuesInt100, flexibility: .infinity)
                    }

                    VStack {
                        Text("String values")
                        PickerCustom<String>(
                            selected: self.$selectedString,
                            values: self.valuesString100
                        )
                    }
                }

                VStack(spacing: 20) {
                    Text("PickerExtended").font(.headline)

                    VStack {
                        Text("0 values")
                        PickerExtended<UInt>(selected: self.$selectedInt, values: self.valuesInt0)
                    }

                    VStack {
                        Text("10 values")
                        PickerExtended<UInt>(selected: self.$selectedInt, values: self.valuesInt10)
                    }

                    VStack {
                        Text("100 values + flexibility")
                        PickerExtended<UInt>(selected: self.$selectedInt, values: self.valuesInt100)
                        PickerExtended<UInt>(selected: self.$selectedInt, values: self.valuesInt100, flexibility: .none)
                        PickerExtended<UInt>(selected: self.$selectedInt, values: self.valuesInt100, flexibility: .size(100))
                        PickerExtended<UInt>(selected: self.$selectedInt, values: self.valuesInt100, flexibility: .infinity)
                    }

                    VStack {
                        Text("String values")
                        PickerExtended<String>(
                            selected: self.$selectedString,
                            values: self.valuesString100
                        )
                    }
                }

                VStack(spacing: 20) {
                    Text("PickerCustomSimple").font(.headline)

                    VStack {
                        Text("0 values")
                        PickerCustomSimple<UInt>(selected: self.$selectedInt, values: self.valuesInt0)
                    }

                    VStack {
                        Text("10 values")
                        PickerCustomSimple<UInt>(selected: self.$selectedInt, values: self.valuesInt10)
                    }

                    VStack {
                        Text("100 values + flexibility")
                        PickerCustomSimple<UInt>(selected: self.$selectedInt, values: self.valuesInt100)
                        PickerCustomSimple<UInt>(selected: self.$selectedInt, values: self.valuesInt100, flexibility: .none)
                        PickerCustomSimple<UInt>(selected: self.$selectedInt, values: self.valuesInt100, flexibility: .size(100))
                        PickerCustomSimple<UInt>(selected: self.$selectedInt, values: self.valuesInt100, flexibility: .infinity)
                    }

                    VStack {
                        Text("String values")
                        PickerCustomSimple<String>(
                            selected: self.$selectedString,
                            values: self.valuesString100
                        )
                    }
                }

                VStack {
                    Text("Picker").font(.headline)
                    Picker("", selection: self.$selectedInt) {
                        ForEach(self.valuesInt100.ordered(), id: \.key) { key, value in
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
