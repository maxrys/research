
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

protocol ColorStatusProtocol {

    var colorScheme       : ColorScheme { get }
    var colorStatusOk     : Color { get }
    var colorStatusWarning: Color { get }
    var colorStatusError  : Color { get }

}

extension ColorStatusProtocol {

    var colorStatusOk     : Color { self.colorScheme != .dark ? .green  : .green.opacity(0.5) }
    var colorStatusWarning: Color { self.colorScheme != .dark ? .orange : .orange.opacity(0.5) }
    var colorStatusError  : Color { self.colorScheme != .dark ? .red    : .red.opacity(0.5) }

}
