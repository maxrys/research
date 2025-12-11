
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct Cell: View {

    var ID: CellID
    var size: CGFloat
    var isVisible: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(self.isVisible ? .blue : .red)
            .frame(width: self.size, height: self.size)
            .overlay(
                Text("ID \(self.ID)")
                    .foregroundColor(.white)
            )
    }

}
