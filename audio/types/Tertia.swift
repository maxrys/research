
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import QuartzCore

let TERTIA_PER_SECOND: Tertia = 60

typealias Tertia = UInt32
extension Tertia {

    static func currentGet() -> Self {
        return Self(
            CACurrentMediaTime() * Double(TERTIA_PER_SECOND)
        )
    }

    enum ToStringMode {
        case hmst, mst, st, t
    }

    func toString(mode: ToStringMode = .mst) -> String {
        var h = String(self / (60 * 60 * 60) % 60); if h.count == 1 { h = "0" + h }
        var m = String(self / (     60 * 60) % 60); if m.count == 1 { m = "0" + m }
        var s = String(self / (          60) % 60); if s.count == 1 { s = "0" + s }
        var t = String(self                  % 60); if t.count == 1 { t = "0" + t }
        switch mode {
            case .hmst: return "\(h):\(m):\(s).\(t)"
            case  .mst: return      "\(m):\(s).\(t)"
            case   .st: return           "\(s).\(t)"
            case    .t: return                "\(t)"
        }
    }

}
