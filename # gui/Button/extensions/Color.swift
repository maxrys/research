
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    static func getNS(_ keyPath: KeyPath<NSColor.Type, NSColor>) -> Color {
        Color(NSColor.self[keyPath: keyPath])
    }

}
