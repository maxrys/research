
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

extension Array {

    @inlinable public var tuples: [(key: Int, value: Element)] {
        get {
            var result: [(key: Int, value: Element)] = []
            for i in 0 ..< self.count {
                result.insert(
                    (key: i, value: self[i]), at: i
                )
            }
            return result
        }
    }

}

@main struct app: App {
    var body: some Scene {
        WindowGroup {

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

    }

}
