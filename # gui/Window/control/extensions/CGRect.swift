
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import CoreGraphics

extension CGRect {

    var x: Double { get { self.minX   } set { self = Self(x: newValue, y: self.y  , width: self.width, height: self.height) } }
    var y: Double { get { self.minY   } set { self = Self(x: self.x  , y: newValue, width: self.width, height: self.height) } }
    var w: Double { get { self.width  } set { self = Self(x: self.x  , y: self.y  , width: newValue  , height: self.height) } }
    var h: Double { get { self.height } set { self = Self(x: self.x  , y: self.y  , width: self.width, height: newValue   ) } }

}
