
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct RadioButton_Enum: View {

    enum Mode {
        case mode0
        case mode1
        case mode2
    }

    @State private var mode: Mode? = .mode0

    public var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            RadioButton(ID: .mode0, self.$mode) {
                Text("Item 1")
            }
            RadioButton(ID: .mode1, self.$mode) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Item 2")
                    Text("some description 1").font(.system(size: 10))
                    Text("some description 2").font(.system(size: 10))
                    Text("some description 3").font(.system(size: 10))
                }
            }
            RadioButton(ID: .mode2, self.$mode, isDisabled: true) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Item 3")
                    Text("disabled").font(.system(size: 10))
                }
            }
        }.padding(20)
    }

}
