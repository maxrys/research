
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    struct StatusColorAltSet {
        let ok      = EnvironmentValues().colorScheme != .dark ? Color.green  : Color.green.opacity(0.5)
        let warning = EnvironmentValues().colorScheme != .dark ? Color.orange : Color.orange.opacity(0.5)
        let error   = EnvironmentValues().colorScheme != .dark ? Color.red    : Color.red.opacity(0.5)
    }

    static let statusAlt = StatusColorAltSet()

}
