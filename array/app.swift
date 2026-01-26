
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

        self.test_arraySafe()
    }

    func test_arraySafe() {
        var data    : [String?] = []
        var expected: [String?] = []

        data = []
        data[safe: 0] = nil
        expected = [nil]
        print(data == expected)

        data = []
        data[safe: 0] = "value 1"
        expected = ["value 1"]
        print(data == expected)

        data = []
        data[safe: 4] = "value 5"
        expected = [nil, nil, nil, nil, "value 5"]
        print(data == expected)

        data = []
        data[safe: 4] = "value 5"
        data[safe: 1] = "value 2"
        data[safe: 6] = "value 7"
        expected = [nil, "value 2", nil, nil, "value 5", nil, "value 7"]
        print(data == expected)

        data = []
        data[safe: 4] = "value 5"
        data[safe: 1] = "value 2"
        data[safe: 6] = "value 7"
        data[safe: 4] = nil
        data[safe: 6] = nil
        expected = [nil, "value 2", nil, nil, nil, nil, nil]
        print(data == expected)
    }

}
