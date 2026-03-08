
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct AlernativeDemo: View {

    public var body: some View {
        VStack {
            Text("Alternative model").font(.headline)
            Message("color Status Ok"     , Color.statusAlt.ok)
            Message("color Status Warning", Color.statusAlt.warning)
            Message("color Status Error"  , Color.statusAlt.error)
        }
    }

}
