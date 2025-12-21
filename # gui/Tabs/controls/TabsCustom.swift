
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct TabsCustom: View {

    typealias TabID = UInt
    typealias TabCollection = [TabID: (
        title: String,
        systemIcon: String?,
        view: any View
    )]

    @Environment(\.colorScheme) private var colorScheme

    @State private var selected: TabID = 0

    private var content: TabCollection = [:]

    init(_ content: TabCollection) {
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 0) {

            HStack(spacing: 0) {
                ForEach(self.content.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }), id: \.key) { key, value in
                    if let item = self.content[key] {
                        self.tabHeader(
                            title: item.title,
                            icon: item.systemIcon,
                            ID: key
                        )
                    }
                }
            }.padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))

            Color(self.colorScheme == .dark ? .white : .black)
                .opacity(0.5)
                .frame(height: 1)

            ZStack {
                if let item = self.content[self.selected] {
                    AnyView(item.view)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color(self.colorScheme == .dark ? .white : .black)
                    .opacity(0.04)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder private func tabHeader(title: String, icon: String? = nil, ID: TabID) -> some View {
        Button {
            self.selected = ID
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
            if (self.selected == ID) {
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
    TabsCustom([
        0: (title: "Tab 1", view: Text("tab 1 content")),
        1: (title: "Tab 2", view: Text("tab 2 content")),
        2: (title: "Tab 3", view: Text("tab 3 content")),
    ] as! TabsCustom.TabCollection).frame(maxWidth: .infinity)
}
