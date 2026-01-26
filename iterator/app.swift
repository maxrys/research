
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

    private var cur: Int = 0
    private var max: Int = 0

    init(_ max: Int) {
        self.max = max
    }

    mutating func next() -> Int? {
        if self.cur < self.max {
            self.cur += 1
            return self.cur
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

    mutating func next() -> Element? {
        if (self.array.count > 0) {
            if (self.index < self.array.count) {
                self.index += 1
                return self.array[
                    self.index - 1
                ]
            }
        }
        return nil
    }

}

struct ArrayDictIterator<Element>: Sequence, IteratorProtocol {

    private var index: Int = 0
    private var array: [Element]

    init(_ array: [Element]) {
        self.array = array
    }

    mutating func next() -> (key: Int, value: Element)? {
        if (self.array.count > 0) {
            if (self.index < self.array.count) {
                self.index += 1
                return (
                    key  :            self.index - 1,
                    value: self.array[self.index - 1]
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

        for value in ArrayIterator(array) {
            print("\(value)")
        }

        for value in ArrayIterator(arrayComplex) {
            print("\(value)")
        }

        for (key, value) in ArrayIterator(arrayTuples) {
            print("\(key):\(value)")
        }

        /* ################################################################ */

        for (key, value) in ArrayDictIterator(array) {
            print("\(key):\(value)")
        }

        for (key, value) in ArrayDictIterator(arrayTuples) {
            print("\(key):\(value)")
        }

        for (key, value) in ArrayDictIterator(arrayComplex) {
            print("\(key):\(value)")
        }

    }

}
