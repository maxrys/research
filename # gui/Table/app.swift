
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
                head: {
                    TableCustom_HeadCell(
                        size: .flexible(),
                        spacing: 0,
                        alignment: .leading
                    ) { Text(NSLocalizedString("Values", comment: "")) }
                    TableCustom_HeadCell(
                        size: .fixed(30),
                        spacing: 0
                    ) { EmptyView() }
                },
                body: {
                    Text("Value 1"); Image(systemName: "1.square")
                    Text("Value 2"); Image(systemName: "2.square")
                    Text("Value 3"); Image(systemName: "3.square")
                    Text("Value 4"); Image(systemName: "4.square")
                    Text("Value 5"); Image(systemName: "5.square")
                }
            )
            .padding(20)
            .frame(width: 250)
        }
    }

}
