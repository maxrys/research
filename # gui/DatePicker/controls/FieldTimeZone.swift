
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct FieldTimeZone: View, Equatable {

    let IS_DEBUG = true

    static func == (lhs: FieldTimeZone, rhs: FieldTimeZone) -> Bool {
        lhs.state.value == rhs.state.value
    }

    @ObservedObject private var state: ValueState<String>

    init(value: String, onChange: @escaping (String) -> Void) {
        self.state = ValueState(value, onChange)
    }

    var body: some View {
        if (self.IS_DEBUG) { let _ = { Logger.customLog("RENDER FieldTimeZone") }() }
        Picker("", selection: self.$state.value) {
            let groups = Date.TIME_ZONES_GROUPPED_LIST.sorted(by: { (lhs, rhs) in lhs.key > rhs.key })
            ForEach(groups, id: \.key) { offsetNumeric, group in
                Section(header: Text(group.groupTitle).font(.system(size: 18))) {
                    let zones = group.groupItems.sorted(by: { (lhs, rhs) in lhs.key < rhs.key })
                    ForEach(zones, id: \.key) { ID, title in
                        Text(title).tag(ID)
                    }
                }
            }
        }
    }

}
