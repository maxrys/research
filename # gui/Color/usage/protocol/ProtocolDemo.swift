
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ProtocolDemo: View, ColorStatusProtocol {

    @Environment(\.colorScheme) internal var colorScheme

    public var body: some View {
        VStack {
            Text("Protocol model").font(.headline)
            Message("color Status Ok"     , self.colorStatusOk)
            Message("color Status Warning", self.colorStatusError)
            Message("color Status Error"  , self.colorStatusWarning)
        }
    }

}
