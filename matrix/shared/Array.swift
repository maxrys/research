
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    subscript<T>(safe index: Index) -> Element? where Element == T? {
        get {
            if (indices.contains(index))
                 { return self[index] }
            else { return nil }
        }
        set {
            guard let newValue else { return }
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
