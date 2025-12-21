
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Tabs: View {

    @Environment(\.colorScheme) private var colorScheme

    @State private var tabSelectedID: UInt = 0

    init() {
    }

    public var body: some View {
        VStack(spacing: 0) {

            HStack(spacing: 0) {
                self.tabHeader(title: NSLocalizedString("Update", comment: ""), icon: "pencil"     , ID: 0)
                self.tabHeader(title: NSLocalizedString("Insert", comment: ""), icon: "plus.circle", ID: 1)
                self.tabHeader(title: NSLocalizedString("Delete", comment: ""), icon: "trash"      , ID: 2)
            }.padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))

            Color(self.colorScheme == .dark ? .white : .black)
                .opacity(0.5)
                .frame(height: 1)

            ZStack {
                if (self.tabSelectedID == 0) { TabUpdate().frame(maxWidth: .infinity) }
                if (self.tabSelectedID == 1) { TabInsert().frame(maxWidth: .infinity) }
                if (self.tabSelectedID == 2) { TabDelete().frame(maxWidth: .infinity) }
            }
            .padding(20)
            .frame(maxHeight: .infinity)
            .background(
                Color(self.colorScheme == .dark ? .white : .black)
                    .opacity(0.04)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder private func tabHeader(title: String, icon: String? = nil, ID: UInt) -> some View {
        Button {
            self.tabSelectedID = ID
        } label: {
            HStack(spacing: 5) {
                if let icon {
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text(title)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.horizontal, 9)
            .padding(.vertical  , 5)
            .contentShape(.focusEffect, TabItemShape(radius: 2))
            .padding(10)
        }
        .buttonStyle(.plain)
        .background {
            if (self.tabSelectedID == ID) {
                VStack(spacing: 0) {
                    Color(self.colorScheme == .dark ? .white : .black)
                        .opacity(0.1)
                    Color.accentColor
                        .frame(height: 3)
                }
            }
        }
        .clipShape(TabItemShape())
        .pointerStyle(.link)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    Tabs().frame(maxWidth: .infinity)
}
