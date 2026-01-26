
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    static let NOT_APPLICABLE = "—"

    @State var selectedKeyInt: UInt = 0
    @State var selectedKeyString: String = ""

    func generatePreviewItems_intKey(count: Int) -> [UInt: String] {
        (1000 ..< 1000 + count).reduce(into: [UInt: String]()) { result, i in
            if (i == 1005) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else           { result[UInt(i)] = "Value \(i)" }
        }
    }

    func generatePreviewItems_strKey(count: Int) -> [String: String] {
        (1000 ..< 1100).reduce(into: [String: String]()) { result, i in
            if (i == 1005) { result["id:\(i)"] = "Value \(i) long long long long long long" }
            else           { result["id:\(i)"] = "Value \(i)" }
        }
    }

    var body: some Scene {
        WindowGroup {
            HStack(spacing: 20) {

                VStack(spacing: 20) {

                    VStack {
                        Text("Items: 0-30, key: int").font(.headline)
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count:  0))
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count:  5))
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 10))
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 15))
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 20))
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 25))
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 30))
                    }

                    VStack {
                        Text("Items: 0-30, key: string").font(.headline)
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count:  0))
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count:  5))
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 10))
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 15))
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 20))
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 25))
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 30))
                    }

                }.frame(minWidth: 250, minHeight: 600)

                VStack(spacing: 20) {

                    VStack {
                        Text("Items: 0-30, key: int, style: plain").font(.headline)
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count:  0), isPlainListStyle: true)
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count:  5), isPlainListStyle: true)
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 10), isPlainListStyle: true)
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 15), isPlainListStyle: true)
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 20), isPlainListStyle: true)
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 25), isPlainListStyle: true)
                        PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 30), isPlainListStyle: true)
                    }

                    VStack {
                        Text("Items: 0-30, key: string, style: plain").font(.headline)
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count:  0), isPlainListStyle: true)
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count:  5), isPlainListStyle: true)
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 10), isPlainListStyle: true)
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 15), isPlainListStyle: true)
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 20), isPlainListStyle: true)
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 25), isPlainListStyle: true)
                        PickerCustom<String>(selected: $selectedKeyString, items: self.generatePreviewItems_strKey(count: 30), isPlainListStyle: true)
                    }

                }.frame(minWidth: 250, minHeight: 600)

                VStack {
                    Text("Flexibility:").font(.headline)
                    PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 30))
                    PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 30), flexibility: .none)
                    PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 30), flexibility: .size(100))
                    PickerCustom<UInt>(selected: $selectedKeyInt, items: self.generatePreviewItems_intKey(count: 30), flexibility: .infinity)
                }
                .padding(20)
                .frame(width: 200)

                VStack {
                    Text("Picker").font(.headline)
                    Picker("", selection: self.$selectedKeyInt) {
                        ForEach(self.generatePreviewItems_intKey(count: 30).ordered(), id: \.key) { key, value in
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
