
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct FieldList<T>: View, Equatable where T: Hashable & Equatable & Comparable {

    static func == (lhs: FieldList, rhs: FieldList) -> Bool {
        lhs.ID          == rhs.ID          &&
        lhs.state.value == rhs.state.value &&
        lhs.items       == rhs.items
    }

    @ObservedObject private var state: FieldValueState<T>

    private let ID: String
    private let items: [T: String]

    init(ID: String, value: T, items: [T: String], onChange: @escaping (T) -> Void) {
        self.ID    = ID
        self.state = FieldValueState(value, onChange)
        self.items = items
    }

    var body: some View {
        let _ = { Logger.customLog("RENDER FieldList with ID = \(self.ID)") }()
        Picker("", selection: self.$state.value) {
            ForEach(Array(self.items.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).enumerated()), id: \.element.key) { index, element in
                Text("\(String(element.value))").tag(element.key)
            }
        }
    }

}
