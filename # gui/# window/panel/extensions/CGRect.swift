
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import CoreGraphics

extension CGRect {

    init(x: Double, y: Double, w: Double, h: Double) {
        self.init(x: x, y: y, width: w, height: h)
    }

    var x: Double { get { self.minX   } set { self = Self(x: newValue, y: self.y  , width: self.w  , height: self.h  ) } }
    var y: Double { get { self.minY   } set { self = Self(x: self.x  , y: newValue, width: self.w  , height: self.h  ) } }
    var w: Double { get { self.width  } set { self = Self(x: self.x  , y: self.y  , width: newValue, height: self.h  ) } }
    var h: Double { get { self.height } set { self = Self(x: self.x  , y: self.y  , width: self.w  , height: newValue) } }

}
