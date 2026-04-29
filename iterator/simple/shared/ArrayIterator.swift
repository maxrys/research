
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

struct ArrayIterator<Element>: Sequence, IteratorProtocol {

    private var index: Int = 0
    private var array: [Element]

    init(_ array: [Element]) {
        self.array = array
    }

    mutating func next() -> (index: Int, value: Element)? {
        if (self.array.count > 0) {
            if (self.index < self.array.count) {
                defer { self.index += 1 }
                return (
                    index:            self.index,
                    value: self.array[self.index]
                )
            }
        }
        return nil
    }

}
