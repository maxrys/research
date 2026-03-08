
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct Message: View {

    private var text: String
    private var background: Color

    init(_ text: String, _ background: Color) {
        self.text       = text
        self.background = background
    }

    public var body: some View {
        Text(self.text)
            .padding(10)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(self.background)
    }

}
