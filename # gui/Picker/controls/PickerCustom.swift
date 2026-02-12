
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PickerCustom<Key>: View where Key: Hashable & Comparable {

    typealias ColorSet = Color.PickerColorSet

    @Binding fileprivate var selectedKey: Key
    @State fileprivate var isOpened: Bool = false

    fileprivate let items: [Key: String]
    fileprivate let isPlainListStyle: Bool
    fileprivate let flexibility: Flexibility
    fileprivate let colorSet: ColorSet
    fileprivate let cornerRadius: CGFloat = 10
    fileprivate let borderWidth: CGFloat = 4

    fileprivate var keyToIndex: [Key: Int] = [:]
    fileprivate var indexToKey: [Int: Key] = [:]
    fileprivate var itemsOrdered: [(key: Key, value: String)] = []

    init(
        selected: Binding<Key>,
        items: [Key: String],
        isPlainListStyle: Bool = false,
        flexibility: Flexibility = .none,
        colorSet: ColorSet = Color.picker
    ) {
        self._selectedKey = selected
        self.items = items
        self.isPlainListStyle = isPlainListStyle
        self.flexibility = flexibility
        self.colorSet = colorSet
        self.itemsOrdered = self.items.ordered()
        self.itemsOrdered.enumerated().forEach { index, keyValuePair in
            self.keyToIndex[keyValuePair.key] = index
            self.indexToKey[index] = keyValuePair.key
        }
    }

    public var body: some View {
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
            Text(self.items[self.selectedKey] ?? ThisApp.NOT_APPLICABLE)
                .lineLimit(1)
                .padding(.horizontal, 9)
                .padding(.vertical  , 5)
                .flexibility(self.flexibility)
                .foregroundPolyfill(self.colorSet.text)
                .background(
                    RoundedRectangle(cornerRadius: self.cornerRadius)
                        .stroke(self.colorSet.border, lineWidth: self.borderWidth)
                        .background(self.colorSet.background))
                .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius))
                .contentShapePolyfill(RoundedRectangle(cornerRadius: self.cornerRadius))
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

}

fileprivate struct PickerCustomPopover<Key>: View where Key: Hashable & Comparable {

    enum Focuser: Hashable {
        case item(index: Int)
    }

    @FocusState private var focuser: Focuser?
    @State private var hoveredKey: Key?

    private var rootView: PickerCustom<Key>

    init(rootView: PickerCustom<Key>) {
        self.rootView = rootView
    }

    public var body: some View {
        if (self.rootView.items.count > 8)
             { self.listWithScroll }
        else { self.list }
    }

    private var list: some View {
        VStack(spacing: 10) {
            ForEach(Array(self.rootView.itemsOrdered.enumerated()), id: \.element.key) { index, item in
                Button {
                    self.rootView.selectedKey = item.key
                    self.rootView.isOpened = false
                } label: {
                    var backgroundColor: Color {
                        if (self.rootView.selectedKey      == item.key) { return self.rootView.colorSet.itemSelectedBackground }
                        if (self.hoveredKey                == item.key) { return self.rootView.colorSet.itemHoveringBackground }
                        if (self.rootView.isPlainListStyle == false   ) { return self.rootView.colorSet.itemBackground }
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
                    self.rootView.selectedKey = self.rootView.itemsOrdered[index].key
                }
            }
            self.rootView.isOpened = false
        }
    }

    private var listWithScroll: some View {
        ScrollViewReader { scrollProxy in
            List {
                ForEach(Array(self.rootView.itemsOrdered.enumerated()), id: \.element.key) { index, item in
                    Button {
                        self.rootView.selectedKey = item.key
                        self.rootView.isOpened = false
                    } label: {
                        var backgroundColor: Color {
                            if (self.rootView.selectedKey      == item.key) { return self.rootView.colorSet.itemSelectedBackground }
                            if (self.hoveredKey                == item.key) { return self.rootView.colorSet.itemHoveringBackground }
                            if (self.rootView.isPlainListStyle == false   ) { return self.rootView.colorSet.itemBackground }
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
                        self.rootView.selectedKey = self.rootView.itemsOrdered[index].key
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

fileprivate func generatePreviewItems_strKey(count: Int) -> [String: String] {
    (1000 ..< 1100).reduce(into: [String: String]()) { result, i in
        if (i == 1005) { result["ID:\(i)"] = "Value \(i) long long long long long long" }
        else           { result["ID:\(i)"] = "Value \(i)" }
    }
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selectedKeyInt: UInt = 0
    @Previewable @State var selectedKeyString: String = ""

    VStack(spacing: 20) {

        VStack {
            Text("Items: 0-30, key: int").font(.headline)
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count:  0))
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count:  5))
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 10))
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 15))
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 20))
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 25))
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 30))
        }

        VStack {
            Text("Items: 0-30, key: string").font(.headline)
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count:  0))
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count:  5))
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 10))
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 15))
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 20))
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 25))
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 30))
        }

    }
    .frame(minWidth: 250, minHeight: 600)
    .background(Color.gray)
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selectedKeyInt: UInt = 0
    @Previewable @State var selectedKeyString: String = ""

    VStack(spacing: 20) {

        VStack {
            Text("Items: 0-30, key: int, style: plain").font(.headline)
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count:  0), isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count:  5), isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 10), isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 15), isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 20), isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 25), isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedKeyInt, items: generatePreviewItems_intKey(count: 30), isPlainListStyle: true)
        }

        VStack {
            Text("Items: 0-30, key: string, style: plain").font(.headline)
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count:  0), isPlainListStyle: true)
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count:  5), isPlainListStyle: true)
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 10), isPlainListStyle: true)
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 15), isPlainListStyle: true)
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 20), isPlainListStyle: true)
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 25), isPlainListStyle: true)
            PickerCustom<String>(selected: $selectedKeyString, items: generatePreviewItems_strKey(count: 30), isPlainListStyle: true)
        }

    }
    .frame(minWidth: 250, minHeight: 600)
    .background(Color.gray)
}


@available(macOS 14.0, *) #Preview {
    @Previewable @State var selected: UInt = 0
    VStack {
        Text("Flexibility:").font(.headline)
        PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 30))
        PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 30), flexibility: .none)
        PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 30), flexibility: .size(100))
        PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 30), flexibility: .infinity)
    }
    .padding(20)
    .frame(width: 200)
    .background(Color.gray)
}
