
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct FieldTimeZone: View, Equatable {

    static func == (lhs: FieldTimeZone, rhs: FieldTimeZone) -> Bool {
        lhs.state.value == rhs.state.value
    }

    @ObservedObject private var state: FieldValueState<String>

    init(value: String, onChange: @escaping (String) -> Void) {
        self.state = FieldValueState(value, onChange)
    }

    var body: some View {
        let _ = { Logger.customLog("RENDER FieldTimeZone") }()
        Picker("", selection: self.$state.value) {
            let groups = Date.TIME_ZONES_GROUPPED_LIST.sorted(by: { (lhs, rhs) in lhs.key > rhs.key })
            ForEach(groups, id: \.key) { offsetNumeric, group in
                Section(header: Text(group.offsetFormatted).font(.system(size: 18))) {
                    let zones = group.items.sorted(by: { (lhs, rhs) in lhs.key < rhs.key })
                    ForEach(zones, id: \.key) { ID, title in
                        Text(title).tag(ID)
                    }
                }
            }
        }
    }

}
