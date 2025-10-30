
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PickerExtended<Key>: View where Key: Hashable & Comparable {

    typealias ColorSet = Color.PickerColorSet

    @State private var isOpened: Bool
    @State private var hovered: Key?
    @State private var selectedIndex: Int = 0
           private var selectedKey: Binding<Key>

    private let values: [Key: String]
    private let isPlainListStyle: Bool
    private let flexibility: Flexibility
    private let colorSet: ColorSet
    private let cornerRadius: CGFloat = 10

    private var valuesList: [(key: Key, value: String)] {
        self.values.sorted(
            by: { $0.key < $1.key }
        )
    }

    init(selected: Binding<Key>, values: [Key: String], isPlainListStyle: Bool = false, flexibility: Flexibility = .none, colorSet: ColorSet = Color.picker) {
        self.selectedKey = selected
        self.values = values
        self.isPlainListStyle = isPlainListStyle
        self.flexibility = flexibility
        self.colorSet = colorSet
        self.isOpened = false
    }

    var body: some View {
        if (self.values.isEmpty) {
            self.main
                .disabled(true)
        } else {
            self.main
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.upArrow  .rawValue) { self.isOpened = true }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.downArrow.rawValue) { self.isOpened = true }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.return   .rawValue) { self.isOpened = true }
                .popover(isPresented: self.$isOpened) {
                    ScrollViewReader { proxy in
                        ScrollView(.vertical) {
                            self.list
                        }
                        .frame(maxHeight: 370)
                        .scrollDisabledPolyfill(self.values.count <= 10)
                        .onKeyPressPolyfill(character: KeyEquivalentPolyfill.upArrow.rawValue) {
                            if (self.selectedIndex > 0) {
                                self.selectedIndex -= 1
                                self.selectedKey.wrappedValue = self.valuesList[self.selectedIndex].key
                                proxy.scrollTo(
                                    self.selectedKey.wrappedValue
                                )
                            }
                        }
                        .onKeyPressPolyfill(character: KeyEquivalentPolyfill.downArrow.rawValue) {
                            if (self.selectedIndex < self.valuesList.count - 1) {
                                self.selectedIndex += 1
                                self.selectedKey.wrappedValue = self.valuesList[self.selectedIndex].key
                                proxy.scrollTo(
                                    self.selectedKey.wrappedValue
                                )
                            }
                        }
                        .onKeyPressPolyfill(character: KeyEquivalentPolyfill.return.rawValue) {
                            self.isOpened = false
                        }
                    }
                }

        }
    }

    @ViewBuilder var main: some View {
        Button {
            self.isOpened = true
        } label: {
            Text(self.values[self.selectedKey.wrappedValue] ?? ThisApp.NA_SIGN)
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

    @ViewBuilder var list: some View {
        VStack (alignment: .leading, spacing: 6) {
            ForEach(Array(valuesList.enumerated()), id: \.element.key) { index, element in
                Button {
                    self.selectedKey.wrappedValue = element.key
                    self.selectedIndex = index
                    self.isOpened = false
                } label: {
                    var backgroundColor: Color {
                        if (self.selectedKey.wrappedValue == element.key) { return self.colorSet.itemSelectedBackground }
                        if (self.hovered                  == element.key) { return self.colorSet.itemHoveredBackground }
                        if (self.isPlainListStyle         == false      ) { return self.colorSet.itemBackground }
                        return Color.clear
                    }
                    Text(element.value)
                        .lineLimit(1)
                        .padding(.horizontal, 9)
                        .padding(.vertical  , 5)
                        .frame(maxWidth: .infinity, alignment: self.isPlainListStyle ? .leading : .center)
                        .foregroundPolyfill(self.colorSet.itemText)
                        .background(backgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius))
                        .contentShapePolyfill(RoundedRectangle(cornerRadius: self.cornerRadius))
                        .onHover { isHovered in
                            self.hovered = isHovered ? element.key : nil
                        }
                }
                .buttonStyle(.plain)
                .id(element.key)
            }
        }.padding(10)
    }

}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selectedV1: UInt = 0
    @Previewable @State var selectedV2: UInt = 0
    @Previewable @State var selectedV3: UInt = 0

    VStack(spacing: 20) {

        /* no value */

        let valuesV1: [UInt: String] = [:]

        VStack {
            Text("No value:").font(.headline)
            PickerExtended<UInt>(selected: $selectedV1, values: valuesV1, isPlainListStyle: true)
            PickerExtended<UInt>(selected: $selectedV1, values: valuesV1)
        }

        /* single value */

        let valuesV2: [UInt: String] = [
            0: "Single value"
        ]

        VStack {
            Text("Single value:").font(.headline)
            PickerExtended<UInt>(selected: $selectedV2, values: valuesV2, isPlainListStyle: true)
            PickerExtended<UInt>(selected: $selectedV2, values: valuesV2)
        }

        /* multiple values */

        let valuesV3 = {
            (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
                if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
                else        { result[UInt(i)] = "Value \(i)" }
            }
        }()

        VStack {
            Text("Multiple values:").font(.headline)
            PickerExtended<UInt>(selected: $selectedV3, values: valuesV3, isPlainListStyle: true)
            PickerExtended<UInt>(selected: $selectedV3, values: valuesV3)
        }

    }
    .padding(20)
    .frame(width: 200)
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selected: String = ""

    let values = {
        (0 ..< 100).reduce(into: [String: String]()) { result, i in
            if (i == 5) { result["id:\(i)"] = "Value \(i) long long long long long long" }
            else        { result["id:\(i)"] = "Value \(i)" }
        }
    }()

    VStack {
        Text("String ID:").font(.headline)
        PickerExtended<String>(selected: $selected, values: values)
    }
    .padding(20)
    .frame(width: 200)
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selected: UInt = 0

    let values = {
        (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
            if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else        { result[UInt(i)] = "Value \(i)" }
        }
    }()

    VStack {
        Text("Flexibility:").font(.headline)
        PickerExtended<UInt>(selected: $selected, values: values)
        PickerExtended<UInt>(selected: $selected, values: values, flexibility: .none)
        PickerExtended<UInt>(selected: $selected, values: values, flexibility: .size(100))
        PickerExtended<UInt>(selected: $selected, values: values, flexibility: .infinity)
    }
    .padding(20)
    .frame(width: 200)
}
