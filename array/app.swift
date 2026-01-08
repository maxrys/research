
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

var arrayDynamic: [String] = [
]

let arrayComplex = [
    ComplexStruct(a: "value 1.1", b: "value 1.2"),
    ComplexStruct(a: "value 2.1", b: "value 2.2"),
]

let arrayTuples = [
    (key: 0, value: ComplexStruct(a: "value 1.1", b: "value 1.2")),
    (key: 1, value: ComplexStruct(a: "value 2.1", b: "value 2.2")),
]

@main struct ThisApp: App {
    var body: some Scene {
        Window("Main", id: "main") {

            ForEach(0 ..< array.count, id: \.self) { key in
                Text("\(key)")
            }

            ForEach(array.indices, id: \.self) { key in
                Text("\(key)")
            }

            ForEach(array.sorted(), id: \.self) { value in
                Text("\(value)")
            }

            ForEach(arrayTuples, id: \.key) { (key, value) in
                Text("\(key):\(value)")
            }

            ForEach(arrayComplex.tuples, id: \.key) { (key, value) in
                Text("\(key):\(value)")
            }

        }
    }

    init() {

        for item in arrayComplex {
            print("\(item)")
        }

        for (key, value) in arrayTuples {
            print("\(key):\(value)")
        }

        for (key, value) in array.enumerated() {
            print("\(key):\(value)")
        }

        for (key, value) in arrayTuples.enumerated() {
            print("\(key):\(value)")
        }

        for (key, value) in arrayComplex.enumerated() {
            print("\(key):\(value)")
        }

        print( array[safe: 0] as Any )
        print( array[safe: 1] as Any )
        print( array[safe: 2] as Any )
        print( array[safe: 3] as Any )

        arrayDynamic[safe: 0] = "value 1"
        arrayDynamic[safe: 1] = "value 2"
        arrayDynamic[safe: 5] = "value 6"
        print( arrayDynamic )
        arrayDynamic[safe: 0] = "value 1 (modified)"
        arrayDynamic[safe: 1] = "value 2 (modified)"
        arrayDynamic[safe: 5] = "value 6 (modified)"
        print( arrayDynamic )

    }

}
