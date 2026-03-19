
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State var selectedRows: Set<Int> = []

    var body: some Scene {
        WindowGroup {
            HStack(spacing: 20) {

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
                    bodyAsArray: [
                        AnyView(Text("Value 1.1")), AnyView(Text("Value 1.2")), AnyView(Text("Value 1.3")), AnyView(Image(systemName: "1.circle")),
                        AnyView(Text("Value 2.1")), AnyView(Text("Value 2.2")), AnyView(Text("Value 2.3")), AnyView(Image(systemName: "2.circle")),
                        AnyView(Text("Value 3.1")), AnyView(Text("Value 3.2")), AnyView(Text("Value 3.3")), AnyView(Image(systemName: "3.circle")),
                        AnyView(Text("Value 4.1")), AnyView(Text("Value 4.2")), AnyView(Text("Value 4.3")), AnyView(Image(systemName: "4.circle")),
                        AnyView(Text("Value 5.1")), AnyView(Text("Value 5.2")), AnyView(Text("Value 5.3")), AnyView(Image(systemName: "5.circle")),
                    ]
                )

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
                    bodyAsViews: {
                        Text("Value 1.1"); Text("Value 1.2"); Text("Value 1.3"); Image(systemName: "1.circle")
                        Text("Value 2.1"); Text("Value 2.2"); Text("Value 2.3"); Image(systemName: "2.circle")
                        Text("Value 3.1"); Text("Value 3.2"); Text("Value 3.3"); Image(systemName: "3.circle")
                        Text("Value 4.1"); Text("Value 4.2"); Text("Value 4.3"); Image(systemName: "4.circle")
                        Text("Value 5.1"); Text("Value 5.2"); Text("Value 5.3"); Image(systemName: "5.circle")
                    }
                )


            }.padding(20)
        }
    }

}
