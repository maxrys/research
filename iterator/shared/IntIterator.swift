
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

struct IntIterator: Sequence, IteratorProtocol {

    private var current: Int = 0
    private var max: Int = 0

    init(_ max: Int) {
        self.max = max
    }

    mutating func next() -> Int? {
        if (self.current < self.max) {
            defer { self.current += 1 }
            return self.current
        }
        return nil
    }

}
