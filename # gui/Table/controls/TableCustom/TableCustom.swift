
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct TableCustom: View {

    @Environment(\.colorScheme) private var colorScheme
    @Binding var selectedRows: Set<Int>
    @State private var lastSelectedRow: Int = 0
    @State private var appIsFocused: Bool = true

    private let headCells: [TableCustom_HeadCell]
    private let bodyCells: [any View]

    init(
        selected selectedRows: Binding<Set<Int>>,
        @ViewBuilderArray<TableCustom_HeadCell> head headCells: () -> [TableCustom_HeadCell],
        @ViewBuilderArray<View>                 body bodyCells: () -> [any View]
    ) {
        self._selectedRows = selectedRows
        self.headCells = headCells()
        self.bodyCells = bodyCells()
    }

    private func rowTextColor(_ isSelected: Bool) -> Color {
        if (isSelected == true && self.appIsFocused == true) { return Color.white }
        if (isSelected != true && self.appIsFocused == true) { return Color.label }
        if (isSelected == true && self.appIsFocused != true) { return Color.label }
        if (isSelected != true && self.appIsFocused != true) { return Color.label }
        return Color.clear
    }

    private func rowBackgroundColor(_ isSelected: Bool, _ isEven: Bool) -> Color {
        if (isSelected != true && isEven != true                             ) { return Color.tableCustom.bodyRowBackground }
        if (isSelected != true && isEven == true                             ) { return Color.tableCustom.bodyRowEvenBackground }
        if (isSelected == true && isEven != true && self.appIsFocused == true) { return Color.selectedContentBackground.opacity(0.9) }
        if (isSelected == true && isEven == true && self.appIsFocused == true) { return Color.selectedContentBackground }
        if (isSelected == true && isEven != true && self.appIsFocused != true) { return Color.selectedContentUnactiveBackground.opacity(0.9) }
        if (isSelected == true && isEven == true && self.appIsFocused != true) { return Color.selectedContentUnactiveBackground }
        return Color.clear
    }

    public var body: some View {
        VStack {
            VStack(spacing: 0) {

                let gridColumns: [GridItem] = (0 ... self.headCells.count - 1).compactMap { index in
                    if let cell = self.headCells[safe: index] {
                        return GridItem(cell.size, spacing: cell.spacing, alignment: cell.alignment)
                    } else {
                        return nil
                    }
                }

                /* MARK: Head */

                LazyVGrid(columns: gridColumns, spacing: 0) {
                    ForEach(self.headCells.indices, id: \.self) { index in
                        if let cell = self.headCells[safe: index] {
                            cell.font(.system(size: 11))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 7)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: cell.alignment ?? .center)
                        }
                    }
                }.background(Color.tableCustom.headBackground)

                Color(self.colorScheme == .dark ? .white : .black)
                    .frame(height: 1)
                    .opacity(0.2)

                /* MARK: Body */

                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 0) {
                        ForEach(0 ..< self.bodyCells.count, id: \.self) { index in
                            if let cell = self.bodyCells[safe: index] {
                                let rowIndex = index / self.headCells.count
                                let colIndex = index % self.headCells.count
                                let isSelected = self.selectedRows.contains(rowIndex)
                                let isEven = rowIndex % 2 == 0
                                AnyView(cell)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: self.headCells[colIndex].alignment ?? .center)
                                    .foregroundPolyfill(self.rowTextColor(isSelected))
                                    .background(self.rowBackgroundColor(isSelected, isEven))
                                    .onTapGesture { self.onClickRow(rowIndex) }
                            }
                        }
                    }
                }.background(Color.tableCustom.bodyBackground)

            }

        }
        .focusable()
        .onKeyPressForSelectAll() {
            Task {
                self.selectedRows = Set(0 ..< self.bodyCells.count)
            }
        }
        .onAppBecomeForeground {
            self.appIsFocused = true
        }
        .onAppBecomeBackground {
            self.appIsFocused = false
        }
    }

    public func onClickRow(_ rowIndex: Int) {
        if (NSEvent.isPressedCommandButton) {
            self.selectedRows.toggle(rowIndex)
        }
        else if (NSEvent.isPressedShiftButton) {
            let lastSelectedRow = self.selectedRows.isEmpty ? 0 : self.lastSelectedRow
            if (lastSelectedRow >= rowIndex)
                 { self.selectedRows.formUnion(rowIndex ... lastSelectedRow) }
            else { self.selectedRows.formUnion(lastSelectedRow ... rowIndex) }
        }
        else {
            self.selectedRows.removeAll()
            self.selectedRows.insert(rowIndex)
        }
        self.lastSelectedRow = rowIndex
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct TableCustom_Previews: PreviewProvider {
    static var previews: some View {
        TableCustom(
            selected: Binding.constant([4]),
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
