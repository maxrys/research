
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ViewPadCell: View {

    static let CELL_SIZE: CGFloat = 30

    @State var isOn = false
    var label: String = ""
    var onChange: (Self) -> Void = { _ in}
    var settings: [String: Level] = [:]

    var body: some View {
        Rectangle()
            .stroke(.black, lineWidth: 1)
            .frame(width: Self.CELL_SIZE, height: Self.CELL_SIZE)
            .background(
                Text(self.label)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        self.isOn ? .gray : .white
                    )
            )
            .onTapGesture {
                self.isOn.toggle()
                self.onChange(self)
            }
    }

}
