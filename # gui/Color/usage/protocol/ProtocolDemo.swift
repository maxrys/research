
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ProtocolDemo: View, ColorStatusProtocol {

    @Environment(\.colorScheme) internal var colorScheme

    public var body: some View {
        VStack {
            Text("Protocol model").font(.headline)
            self.Message("color Status Ok"     , self.colorStatusOk)
            self.Message("color Status Warning", self.colorStatusError)
            self.Message("color Status Error"  , self.colorStatusWarning)
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
