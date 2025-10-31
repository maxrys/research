
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PickerCustom<Key>: View where Key: Hashable & Comparable {

    typealias ColorSet = Color.PickerColorSet

    @State fileprivate var isOpened: Bool = false

    fileprivate var selectedKey: Binding<Key>
    fileprivate let items: [Key: String]
    fileprivate let isPlainListStyle: Bool
    fileprivate let flexibility: Flexibility
    fileprivate let colorSet: ColorSet
    fileprivate let cornerRadius: CGFloat = 10

    init(
        selected: Binding<Key>,
        items: [Key: String],
        isPlainListStyle: Bool = false,
        flexibility: Flexibility = .none,
        colorSet: ColorSet = Color.picker
    ) {
        self.selectedKey = selected
        self.items = items
        self.isPlainListStyle = isPlainListStyle
        self.flexibility = flexibility
        self.colorSet = colorSet
    }

    var body: some View {
        if (self.items.isEmpty) {
            self.opener
                .disabled(true)
        } else {
            self.opener
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.upArrow  .rawValue) { self.isOpened = true }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.downArrow.rawValue) { self.isOpened = true }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.return   .rawValue) { self.isOpened = true }
                .popover(isPresented: self.$isOpened) {
                    PickerCustomPopover<Key>(
                        rootView: self
                    )
                }
        }
    }

    @ViewBuilder var opener: some View {
        Button {
            self.isOpened = true
        } label: {
            Text(self.items[self.selectedKey.wrappedValue] ?? ThisApp.NA_SIGN)
                .lineLimit(1)
                .padding(.horizontal, 9)
                .padding(.vertical  , 5)
                .flexibility(self.flexibility)
                .foregroundPolyfill(self.colorSet.text)
                .background {
                    RoundedRectangle(cornerRadius: self.cornerRadius)
                        .stroke(self.colorSet.border, lineWidth: 4)
                        .background(self.colorSet.background) }
                .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius))
                .contentShapePolyfill(RoundedRectangle(cornerRadius: self.cornerRadius))
        }
        .buttonStyle(.plain)
        .onHoverCursor()
    }

}

fileprivate struct PickerCustomPopover<Key>: View where Key: Hashable & Comparable {

    typealias ColorSet = Color.PickerColorSet

    enum Focuser: Hashable {
        case item(index: Int)
    }

    @FocusState private var focuser: Focuser?
    @State private var hovered: Key?

    private var rootView: PickerCustom<Key>
    private var itemsList: [(key: Key, value: String)] {
        self.rootView.items.ordered()
    }

    init(rootView: PickerCustom<Key>) {
        self.rootView = rootView
    }

    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(Array(itemsList.enumerated()), id: \.element.key) { index, item in
                    Button {
                        self.rootView.selectedKey.wrappedValue = item.key
                        self.rootView.$isOpened.wrappedValue = false
                    } label: {
                        var backgroundColor: Color {
                            if (self.rootView.selectedKey.wrappedValue == item.key) { return self.rootView.colorSet.itemSelectedBackground }
                            if (self.hovered                           == item.key) { return self.rootView.colorSet.itemHoveredBackground }
                            if (self.rootView.isPlainListStyle         == false   ) { return self.rootView.colorSet.itemBackground }
                            return Color.clear
                        }
                        Text(item.value)
                            .lineLimit(1)
                            .padding(.horizontal, 9)
                            .padding(.vertical  , 5)
                            .frame(maxWidth: .infinity, alignment: self.rootView.isPlainListStyle ? .leading : .center)
                            .foregroundPolyfill(self.rootView.colorSet.itemText)
                            .background(backgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: self.rootView.cornerRadius))
                            .contentShapePolyfill(RoundedRectangle(cornerRadius: self.rootView.cornerRadius))
                            .onHover { isHovered in
                                self.hovered = isHovered ? item.key : nil
                            }
                    }
                    .buttonStyle(.plain)
                    .focused(self.$focuser, equals: .item(index: index))
                    .id(index)
                }
            }
            .onAppear {
                self.focuser = .item(index: 0)
            }
            .onKeyPressPolyfill(character: KeyEquivalentPolyfill.upArrow.rawValue) {
                if case .item(let index) = self.focuser {
                    if (index > 0) {
                        self.focuser = .item(index: index - 1)
                        proxy.scrollTo(index - 1)
                    }
                }
            }
            .onKeyPressPolyfill(character: KeyEquivalentPolyfill.downArrow.rawValue) {
                if case .item(let index) = self.focuser {
                    if (index < self.rootView.items.count - 1) {
                        self.focuser = .item(index: index + 1)
                        proxy.scrollTo(index + 1)
                    }
                }
            }
            .onKeyPressPolyfill(character: KeyEquivalentPolyfill.return.rawValue) {
                if case .item(let index) = self.focuser {
                    if (index >= 0 && index <= self.rootView.items.count - 1) {
                        self.rootView.selectedKey.wrappedValue = self.itemsList[index].key
                    }
                }
                self.rootView.$isOpened.wrappedValue = false
            }
        }
    }

}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selectedV1: UInt = 0
    @Previewable @State var selectedV2: UInt = 0
    @Previewable @State var selectedV3: UInt = 0

    VStack(spacing: 20) {

        /* no value */

        let itemsV1: [UInt: String] = [:]

        VStack {
            Text("No value:").font(.headline)
            PickerCustom<UInt>(selected: $selectedV1, items: itemsV1, isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV1, items: itemsV1)
        }

        /* single value */

        let itemsV2: [UInt: String] = [
            0: "Single value"
        ]

        VStack {
            Text("Single value:").font(.headline)
            PickerCustom<UInt>(selected: $selectedV2, items: itemsV2, isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV2, items: itemsV2)
        }

        /* multiple values */

        let itemsV3 = {
            (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
                if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
                else        { result[UInt(i)] = "Value \(i)" }
            }
        }()

        VStack {
            Text("Multiple values:").font(.headline)
            PickerCustom<UInt>(selected: $selectedV3, items: itemsV3, isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV3, items: itemsV3)
        }

    }
    .padding(20)
    .frame(width: 200)
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selected: String = ""

    let items = {
        (0 ..< 100).reduce(into: [String: String]()) { result, i in
            if (i == 5) { result["id:\(i)"] = "Value \(i) long long long long long long" }
            else        { result["id:\(i)"] = "Value \(i)" }
        }
    }()

    VStack {
        Text("String ID:").font(.headline)
        PickerCustom<String>(selected: $selected, items: items)
    }
    .padding(20)
    .frame(width: 200)
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selected: UInt = 0

    let items = {
        (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
            if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else        { result[UInt(i)] = "Value \(i)" }
        }
    }()

    VStack {
        Text("Flexibility:").font(.headline)
        PickerCustom<UInt>(selected: $selected, items: items)
        PickerCustom<UInt>(selected: $selected, items: items, flexibility: .none)
        PickerCustom<UInt>(selected: $selected, items: items, flexibility: .size(100))
        PickerCustom<UInt>(selected: $selected, items: items, flexibility: .infinity)
    }
    .padding(20)
    .frame(width: 200)
}
