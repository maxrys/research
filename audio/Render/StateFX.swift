
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

final class StateFX {

    var levelX: UInt8 = 1
    var levelY: UInt8 = 1

    var cols: UInt8 = 9
    var rows: UInt8 = 9

    var isEnabled: [FXType: Bool] = [
        .pitch     : true,
        .speed     : false,
        .delay     : false,
        .distortion: false,
        .reverb    : false,
        .equalizer : false,
    ]

    convenience init(from: StateFX, levelX: Level? = nil, levelY: Level? = nil, cols: UInt8? = nil, rows: UInt8? = nil) {
        self.init()
        self.levelX = levelX != nil ? levelX! : from.levelX
        self.levelY = levelY != nil ? levelY! : from.levelY
        self.cols = cols != nil ? cols! : from.cols
        self.rows = rows != nil ? rows! : from.rows
        self.isEnabled = from.isEnabled
    }

    func isEnabledSomeVisibleFX() -> Bool {
        return self.isEnabledGet(.delay)      ||
               self.isEnabledGet(.distortion) ||
               self.isEnabledGet(.reverb)
    }

    func isEnabledGet(_ type: FXType) -> Bool {
        return self.isEnabled[type] ?? false
    }

    func isEnabledSet(_ type: FXType, _ value: Bool) {
        self.isEnabled[type] = value
    }

    func levelsSet(levelX: Level, levelY: Level, cols: UInt8, rows: UInt8) {
        self.levelX = levelX
        self.levelY = levelY
        self.cols = cols
        self.rows = rows
    }

}
