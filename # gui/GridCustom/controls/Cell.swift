
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

protocol CellProtocol: View {
    var ID       : CellID.Value { get }
    var size     : CGFloat      { get }
    var isVisible: Bool         { get set }
}

struct Cell: View, CellProtocol {

    var ID: CellID.Value
    var size: CGFloat
    var isVisible: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(self.isVisible ? .blue : .red)
            .frame(width: self.size, height: self.size)
            .overlay(
                Text("\(self.ID)")
                    .foregroundColor(.white)
            )
    }

}
