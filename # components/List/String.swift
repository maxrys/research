
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension String {

    subscript(position: Int) -> Character {
        let index = position >= 0 ? self.startIndex : self.endIndex
        return self[self.index(index, offsetBy: position)]
    }

    subscript(startPosition: Int, endPosition: Int) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: startPosition)
        let endIndex = self.index(self.startIndex, offsetBy: endPosition)
        return self[startIndex ... endIndex]
    }

}
