
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

/* Button */

extension Color {

    struct ButtonColorSet {

        enum Style {

            case accent
            case custom

            var text: Color {
                switch self {
                    case .accent: Color.white
                    case .custom: Color("color ButtonCustom Text")
                }
            }

            var background: Color {
                switch self {
                    case .accent: Color.accentColor
                    case .custom: Color("color ButtonCustom Background")
                }
            }
        }

    }

}
