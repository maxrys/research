
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct TabsCustom: View {

    @Environment(\.colorScheme) private var colorScheme

    @State private var selected: Int = 0

    private let contents: [TabItemCustom]

    init(@ViewBuilderArray<TabItemCustom> content: () -> [TabItemCustom]) {
        self.contents = content()
    }

    public var body: some View {
        VStack(spacing: 0) {

            HStack(spacing: 10) {
                ForEach(0 ..< self.contents.count, id: \.self) { index in
                    if let tabItem = self.contents[safe: index] {
                        self.tabHeader(
                            title: tabItem.title,
                            icon: tabItem.systemIcon,
                            index: index
                        )
                    }
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(
                self.colorScheme == .dark ?
                    .black.opacity(0.2) :
                    .white.opacity(0.5)
            )
            .overlay(alignment: .bottom) {
                self.shadow
                    .offset(y: 5)
            }

            ZStack {
                if let tabItem = self.contents[safe: self.selected] {
                    tabItem.frame(maxWidth: .infinity)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder private func tabHeader(title: String, icon: String? = nil, index: Int) -> some View {
        Button {
            self.selected = index
        } label: {
            HStack(spacing: 7) {
                if let icon {
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                Text(title)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(10)
            .contentShape(.focusEffect, Capsule())
        }
        .buttonStyle(.plain)
        .pointerStyle(.link)
        .foregroundStyle(
            self.selected == index ? Color.white :
                (self.colorScheme == .dark ?
                    Color.white :
                    Color.black
                )
        )
        .background {
            if (self.selected == index) {
                Color.accentColor
            }
        }
        .clipShape(Capsule())
    }

    @ViewBuilder private var shadow: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        self.colorScheme == .dark ?
                            .black.opacity(0.5) :
                            .black.opacity(0.2),
                        Color.clear ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            ).frame(height: 5)
    }

}

struct TabItemCustom: View {

    var title: String
    var systemIcon: String?
    var view: any View

    init(
        title: String,
        systemIcon: String?,
        @ViewBuilder view: () -> any View
    ) {
        self.title = title
        self.systemIcon = systemIcon
        self.view = view()
    }

    public var body: some View {
        AnyView(self.view)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    TabsCustom {
        TabItemCustom(title: "Update", systemIcon: "pencil.tip.crop.circle") { TabUpdate() }
        TabItemCustom(title: "Insert", systemIcon: "plus.circle"           ) { TabInsert() }
        TabItemCustom(title: "Delete", systemIcon: "trash"                 ) { TabDelete() }
    }.frame(maxWidth: 350)
}
