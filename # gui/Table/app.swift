
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State var selectedRows: Set<Int> = []

    var body: some Scene {
        WindowGroup {
            TableCustom(
                selected: self.$selectedRows,
                isVisibleHeader: true,
                isFocusable: true,
                selectionType: .multiple,
                head: {
                    TableCustom_HeadCell(
                        size: .flexible(),
                        spacing: 1,
                        alignment: .leading
                    ) { Text(NSLocalizedString("Column 1", comment: "")).font(.system(size: 11)) }
                    TableCustom_HeadCell(
                        size: .flexible(),
                        spacing: 1,
                        alignment: .center
                    ) { Text(NSLocalizedString("Column 2", comment: "")).font(.system(size: 11)) }
                    TableCustom_HeadCell(
                        size: .flexible(),
                        spacing: 1,
                        alignment: .trailing
                    ) { Text(NSLocalizedString("Column 3", comment: "")).font(.system(size: 11)) }
                    TableCustom_HeadCell(
                        size: .fixed(30),
                        spacing: 1
                    ) { EmptyView() }
                },
                body: {
                    Text("Value 1.1"); Text("Value 1.2"); Text("Value 1.3"); Image(systemName: "1.square")
                    Text("Value 2.1"); Text("Value 2.2"); Text("Value 2.3"); Image(systemName: "2.square")
                    Text("Value 3.1"); Text("Value 3.2"); Text("Value 3.3"); Image(systemName: "3.square")
                    Text("Value 4.1"); Text("Value 4.2"); Text("Value 4.3"); Image(systemName: "4.square")
                    Text("Value 5.1"); Text("Value 5.2"); Text("Value 5.3"); Image(systemName: "5.square")
                }
            )
            .padding(20)
            .frame(maxWidth: .infinity)
        }
    }

}
