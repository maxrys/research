
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

struct Note {

    static let MIN_LENGTH: Tertia = 1
    static let MAX_LENGTH: Tertia = 50

    var timeStart: Tertia
    var length: Tertia
    var levelX: Level
    var levelY: Level
    var stateFX: StateFX?

    var timeEnd: Tertia {
        get {
            self.timeStart + self.length
        }
    }

}
