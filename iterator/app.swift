
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ComplexStruct: Hashable {
    let a: String
    let b: String
}

let array = [
    "value1",
    "value2",
]

let arrayComplex = [
    ComplexStruct(a: "value 1.1", b: "value 1.2"),
    ComplexStruct(a: "value 2.1", b: "value 2.2"),
]

let arrayTuples = [
    (key: 0, value: ComplexStruct(a: "value 1.1", b: "value 1.2")),
    (key: 1, value: ComplexStruct(a: "value 2.1", b: "value 2.2")),
]

struct IntIterator: Sequence, IteratorProtocol {

    private var current: Int = 0
    private var max: Int = 0

    init(_ max: Int) {
        self.max = max
    }

    mutating func next() -> Int? {
        if (self.current < self.max) {
            self.current += 1
            return self.current
        }
        return nil
    }

}

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

@main struct ThisApp: App {

    let intIterator = IntIterator(3)

    var body: some Scene {
        Window("Main", id: "main") {

            ForEach(self.intIterator.sorted(), id: \.self) { value in
                Text("\(value)")
            }

        }
    }

    init() {

        for value in intIterator {
            print("\(value)")
        }

        for value in IntIterator(3) {
            print("\(value)")
        }

        var arrayIterator = arrayComplex.makeIterator()
        while let item = arrayIterator.next() {
            print("\(item)")
        }

        /* ################################################################ */

        for (index, value) in ArrayIterator(array) {
            print("\(index):\(value)")
        }

        for (index, value) in ArrayIterator(arrayComplex) {
            print("\(index):\(value)")
        }

        for (index, value) in ArrayIterator(arrayTuples) {
            print("\(index):\(value)")
        }

    }

}
