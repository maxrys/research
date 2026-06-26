
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct RadioButton_Simple: View {

    static let DEMO_ID_0: UInt = 0
    static let DEMO_ID_1: UInt = 1
    static let DEMO_ID_2: UInt = 2

    @State private var selected: UInt? = 0

    public var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            RadioButtonSimple(isSelected: self.selected == Self.DEMO_ID_0, onSelect: { self.selected = Self.DEMO_ID_0 }) {
                Text("Item 1")
            }
            RadioButtonSimple(isSelected: self.selected == Self.DEMO_ID_1, onSelect: { self.selected = Self.DEMO_ID_1 }) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Item 2")
                    Text("some description 1").font(.system(size: 10))
                    Text("some description 2").font(.system(size: 10))
                    Text("some description 3").font(.system(size: 10))
                }
            }
            RadioButtonSimple(isSelected: self.selected == Self.DEMO_ID_2, onSelect: { self.selected = Self.DEMO_ID_2 }) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Item 3")
                    Text("disabled").font(.system(size: 10))
                }
            }.disabled(true)
        }.padding(20)
    }

}
