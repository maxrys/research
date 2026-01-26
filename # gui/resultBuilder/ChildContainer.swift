
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ChildContainer: View {

    var title: String
    var view: any View

    init(
        title: String,
        @ViewBuilder view: () -> any View
    ) {
        self.title = title
        self.view = view()
    }

    public var body: some View {
        AnyView(self.view)
    }

}
