
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

@resultBuilder struct ViewBuilderCustom<T> {
    static func buildBlock(_ components: T...) -> [T] {
        components
    }
}

struct TabsCustom: View {

    @Environment(\.colorScheme) private var colorScheme

    @State private var selected: Int = 0

    private let contents: [TabItemCustom]

    init(@ViewBuilderCustom<TabItemCustom> content: () -> [TabItemCustom]) {
        self.contents = content()
    }

    public var body: some View {
        VStack(spacing: 0) {

            HStack(spacing: 0) {
                ForEach(0 ..< self.contents.count, id: \.self) { index in
                    if let tabItem = self.contents[safe: index] {
                        self.tabHeader(
                            title: tabItem.title,
                            icon: tabItem.systemIcon,
                            index: index
                        )
                    }
                }
            }.padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))

            Color(self.colorScheme == .dark ? .white : .black)
                .opacity(0.5)
                .frame(height: 1)

            ZStack {
                if let tabItem = self.contents[safe: self.selected] {
                    tabItem.frame(maxWidth: .infinity)
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

    @ViewBuilder private func tabHeader(title: String, icon: String? = nil, index: Int) -> some View {
        Button {
            self.selected = index
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
            if (self.selected == index) {
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
        TabItemCustom(title: "Update", systemIcon: "pencil"     ) { TabUpdate() }
        TabItemCustom(title: "Insert", systemIcon: "plus.circle") { TabInsert() }
        TabItemCustom(title: "Delete", systemIcon: "trash"      ) { TabDelete() }
    }.frame(maxWidth: .infinity)
}
