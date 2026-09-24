
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    enum StatusColorSet {
        static let ok      = Color("color Status Ok")
        static let warning = Color("color Status Warning")
        static let error   = Color("color Status Error")
    }

    static let status = StatusColorSet.self

}
