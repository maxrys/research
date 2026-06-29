
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    subscript<T>(safe index: Index) -> T? where Element == T? {
        get {
            if (indices.contains(index))
                 { return self[index] }
            else { return nil }
        }
        set {
            if      (index <  self.count) { self[index] = newValue }
            else if (index == self.count) { self.append(newValue) }
            else if (index >  self.count) {
                for i in self.count ... index {
                    if (i != index) { self.append(nil) }
                    if (i == index) { self.append(newValue) }
                }
            }
        }
    }

}
