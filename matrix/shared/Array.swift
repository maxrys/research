
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Array {

    subscript(safe index: Index) -> Element? {
        get {
            indices.contains(index) ? self[index] : nil
        }
        set {
            guard let newValue else { return }
            if      (index <  self.count) { self[index] = newValue }
            else if (index == self.count) { self.append(newValue) }
            else if (index >  self.count) { /* do nothing */ }
        }
    }

}
