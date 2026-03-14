
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

enum MessageLifeTime {

    static let LIFE_TIME_DEFAULT: CFTimeInterval = 3.0

    case time(Double)
    case infinity

}
