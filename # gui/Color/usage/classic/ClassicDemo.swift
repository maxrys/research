
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ClassicDemo: View {

    public var body: some View {
        VStack {
            Text("Classic model").font(.headline)
            self.Message("color Status Ok"     , Color.status.ok)
            self.Message("color Status Warning", Color.status.warning)
            self.Message("color Status Error"  , Color.status.error)
        }
    }

    @ViewBuilder private func Message(_ text: String, _ background: Color) -> some View {
        Text(text)
            .padding(10)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(background)
    }

}
