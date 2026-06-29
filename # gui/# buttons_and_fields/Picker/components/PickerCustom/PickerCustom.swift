
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PickerCustom<Key>: View where Key: Hashable & Comparable {

    typealias ColorSet = Color.PickerColorSet

    @Environment(\.isEnabled) private var isEnabled
    @Binding fileprivate var selectedKey: Key
    @State fileprivate var isOpened = false

    fileprivate let items: [Key: String]
    fileprivate let sortedBy: Dictionary<Key, String>.OrderBy
    fileprivate let isPlainListStyle: Bool
    fileprivate let flexibility: Flexibility
    fileprivate let colorSet: ColorSet
    fileprivate let cornerRadius: CGFloat = 10
    fileprivate let borderWidth: CGFloat = 1

    fileprivate var keyToIndex: [Key: Int] = [:]
    fileprivate var indexToKey: [Int: Key] = [:]
    fileprivate var itemsSorted: [(key: Key, value: String)] = []

    init(
        selected: Binding<Key>,
        items: [Key: String],
        sortedBy: Dictionary<Key, String>.OrderBy = .keyAscending,
        isPlainListStyle: Bool = false,
        flexibility: Flexibility = .none,
        colorSet: ColorSet = Color.picker
    ) {
        self._selectedKey = selected
        self.items = items
        self.sortedBy = sortedBy
        self.isPlainListStyle = isPlainListStyle
        self.flexibility = flexibility
        self.colorSet = colorSet
        self.itemsSorted = self.items.sorted(order: self.sortedBy)
        self.itemsSorted.enumerated().forEach { index, keyValuePair in
            self.keyToIndex[keyValuePair.key] = index
            self.indexToKey[index] = keyValuePair.key
        }
    }

    public var body: some View {
        if (self.items.isEmpty) {
            self.OpenerView()
                .disabled(true)
        } else {
            self.OpenerView()
                .disabled(!self.isEnabled)
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

    @ViewBuilder private func OpenerView() -> some View {
        Button {
            self.isOpened = true
        } label: {
            Text(self.items[self.selectedKey] ?? ThisApp.NOT_APPLICABLE)
                .lineLimit(1)
                .padding(.horizontal, 9)
                .padding(.vertical  , 5)
                .flexibility(self.flexibility)
                .foregroundPolyfill(self.colorSet.text)
                .background(
                    RoundedRectangle(cornerRadius: self.cornerRadius)
                        .stroke(self.colorSet.border, lineWidth: self.borderWidth)
                        .background(self.colorSet.background)
                        .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius)))
                .contentShape(RoundedRectangle(cornerRadius: self.cornerRadius))
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill(self.isEnabled)
    }

}

fileprivate struct PickerCustomPopover<Key>: View where Key: Hashable & Comparable {

    enum Focuser: Hashable {
        case item(index: Int)
    }

    @FocusState private var focuser: Focuser?
    @State private var hoveredKey: Key?

    private let rootView: PickerCustom<Key>

    init(rootView: PickerCustom<Key>) {
        self.rootView = rootView
    }

    public var body: some View {
        if (self.rootView.items.count > 8)
             { self.ListWithScroll() }
        else { self.ListView() }
    }

    @ViewBuilder private func ListView() -> some View {
        VStack(spacing: 10) {
            ForEach(Array(self.rootView.itemsSorted.enumerated()), id: \.element.key) { index, item in
                Button {
                    self.rootView.selectedKey = item.key
                    self.rootView.isOpened = false
                } label: {
                    let backgroundColor = {
                        if (self.rootView.selectedKey      == item.key) { return self.rootView.colorSet.itemSelectedBackground }
                        if (self.hoveredKey                == item.key) { return self.rootView.colorSet.itemHoveringBackground }
                        if (self.rootView.isPlainListStyle == false   ) { return self.rootView.colorSet.itemBackground }
                        return Color.clear
                    }()
                    Text(item.value)
                        .lineLimit(1)
                        .padding(.horizontal, 9)
                        .padding(.vertical  , 5)
                        .frame(maxWidth: .infinity, alignment: self.rootView.isPlainListStyle ? .leading : .center)
                        .foregroundPolyfill(self.rootView.colorSet.itemText)
                        .background(
                            RoundedRectangle(cornerRadius: self.rootView.cornerRadius)
                                .fill(backgroundColor))
                        .contentShape(RoundedRectangle(cornerRadius: self.rootView.cornerRadius))
                        .onHover { isHovering in
                            self.hoveredKey = isHovering ? item.key : nil
                        }
                }
                .pointerStyleLinkPolyfill()
                .buttonStyle(.plain)
                .focused(self.$focuser, equals: .item(index: index))
                .id(index)
            }
        }
        .padding(10)
        .onAppear {
            let index = self.rootView.keyToIndex[self.rootView.selectedKey] ?? 0
            self.focuser = .item(index: index)
        }
        .onKeyPressPolyfill(character: KeyEquivalentPolyfill.upArrow.rawValue) {
            if case .item(let index) = self.focuser {
                if (index > 0) {
                    self.focuser = .item(index: index - 1)
                }
            }
        }
        .onKeyPressPolyfill(character: KeyEquivalentPolyfill.downArrow.rawValue) {
            if case .item(let index) = self.focuser {
                if (index < self.rootView.items.count - 1) {
                    self.focuser = .item(index: index + 1)
                }
            }
        }
        .onKeyPressPolyfill(character: KeyEquivalentPolyfill.return.rawValue) {
            if case .item(let index) = self.focuser {
                if (index >= 0 && index <= self.rootView.items.count - 1) {
                    self.rootView.selectedKey = self.rootView.itemsSorted[index].key
                }
            }
            self.rootView.isOpened = false
        }
    }

    @ViewBuilder private func ListWithScroll() -> some View {
        ScrollViewReader { scrollProxy in
            List {
                ForEach(Array(self.rootView.itemsSorted.enumerated()), id: \.element.key) { index, item in
                    Button {
                        self.rootView.selectedKey = item.key
                        self.rootView.isOpened = false
                    } label: {
                        let backgroundColor = {
                            if (self.rootView.selectedKey      == item.key) { return self.rootView.colorSet.itemSelectedBackground }
                            if (self.hoveredKey                == item.key) { return self.rootView.colorSet.itemHoveringBackground }
                            if (self.rootView.isPlainListStyle == false   ) { return self.rootView.colorSet.itemBackground }
                            return Color.clear
                        }()
                        Text(item.value)
                            .lineLimit(1)
                            .padding(.horizontal, 9)
                            .padding(.vertical  , 5)
                            .frame(maxWidth: .infinity, alignment: self.rootView.isPlainListStyle ? .leading : .center)
                            .foregroundPolyfill(self.rootView.colorSet.itemText)
                            .background(
                                RoundedRectangle(cornerRadius: self.rootView.cornerRadius)
                                    .fill(backgroundColor))
                            .contentShape(RoundedRectangle(cornerRadius: self.rootView.cornerRadius))
                            .onHover { isHovering in
                                self.hoveredKey = isHovering ? item.key : nil
                            }
                    }
                    .pointerStyleLinkPolyfill()
                    .buttonStyle(.plain)
                    .focused(self.$focuser, equals: .item(index: index))
                    .id(index)
                }
            }
            .listStyle(.sidebar)
            .onAppear {
                let index = self.rootView.keyToIndex[self.rootView.selectedKey] ?? 0
                self.focuser = .item(index: index)
            }
            .onKeyPressPolyfill(character: KeyEquivalentPolyfill.upArrow.rawValue) {
                if case .item(let index) = self.focuser {
                    if (index > 0) {
                        self.focuser = .item(index: index - 1)
                        scrollProxy.scrollTo(index - 1)
                    }
                }
            }
            .onKeyPressPolyfill(character: KeyEquivalentPolyfill.downArrow.rawValue) {
                if case .item(let index) = self.focuser {
                    if (index < self.rootView.items.count - 1) {
                        self.focuser = .item(index: index + 1)
                        scrollProxy.scrollTo(index + 1)
                    }
                }
            }
            .onKeyPressPolyfill(character: KeyEquivalentPolyfill.return.rawValue) {
                if case .item(let index) = self.focuser {
                    if (index >= 0 && index <= self.rootView.items.count - 1) {
                        self.rootView.selectedKey = self.rootView.itemsSorted[index].key
                    }
                }
                self.rootView.isOpened = false
            }
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

fileprivate func generatePreviewItems_intKey(count: Int) -> [UInt: String] {
    (1000 ..< 1000 + count).reduce(into: [UInt: String]()) { result, i in
        if (i == 1005) { result[UInt(i)] = "Value \(i) long long long long long long" }
        else           { result[UInt(i)] = "Value \(i)" }
    }
}

struct PickerCustom_Previews1: PreviewProvider {
    struct ViewWithState: View {
        @State private var selectedV1: UInt = 0
        @State private var selectedV2: UInt = 0
        @State private var selectedV3: UInt = 0
        public var body: some View {
            Previewer(axis: .horizontal, spacing: 20, padding: 20) {

                VStack {
                    Text("No value:").font(.headline)
                    PickerCustom<UInt>(selected: $selectedV1, items: generatePreviewItems_intKey(count: 0), isPlainListStyle: true)
                    PickerCustom<UInt>(selected: $selectedV1, items: generatePreviewItems_intKey(count: 0))
                }

                VStack {
                    Text("Single value:").font(.headline)
                    PickerCustom<UInt>(selected: $selectedV2, items: generatePreviewItems_intKey(count: 1), isPlainListStyle: true)
                    PickerCustom<UInt>(selected: $selectedV2, items: generatePreviewItems_intKey(count: 1))
                }

                VStack {
                    Text("Multiple values:").font(.headline)
                    PickerCustom<UInt>(selected: $selectedV3, items: generatePreviewItems_intKey(count: 9), isPlainListStyle: true)
                    PickerCustom<UInt>(selected: $selectedV3, items: generatePreviewItems_intKey(count: 9))
                }

            }
        }
    }
    static public var previews: some View {
        ViewWithState()
    }
}

struct PickerCustom_Previews2: PreviewProvider {
    struct ViewWithState: View {
        @State private var selected: UInt = 0
        public var body: some View {
            Previewer(spacing: 10, padding: 20) {
                Text("Flexibility:").font(.headline)
                PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 10))
                PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 10), flexibility: .none)
                PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 10), flexibility: .size(100))
                PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 10), flexibility: .infinity)
            }.frame(width: 200)
        }
    }
    static public var previews: some View {
        ViewWithState()
    }
}
