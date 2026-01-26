
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import QuartzCore

struct ComplexStruct: Hashable {
    let a: String
    let b: String
}

var dictIntKeys: [Int: String] = [
    1: "Item 1",
    5: "Item 5",
 // 3: ← hole
    4: "Item 4",
    2: "Item 2",
]

var dictStrKeys = [
    "key1": "value1",
    "key5": "value5",
 // "key3": ← hole
    "key4": "value4",
    "key2": "value2",
]

var dictComplex = [
    "key1": ComplexStruct(a: "value 1.1", b: "value 1.2"),
    "key5": ComplexStruct(a: "value 5.1", b: "value 5.2"),
 // "key3": ← hole
    "key4": ComplexStruct(a: "value 4.1", b: "value 4.2"),
    "key2": ComplexStruct(a: "value 2.1", b: "value 2.2"),
]

var dictIntKeysEmpty: [Int: String] = [:]

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") { ScrollView {
            
            // ordered
            
            ForEach(dictIntKeys.ordered(), id: \.key) { key, value in
                Text("\(key) = \(value)")
            }

            ForEach(dictStrKeys.ordered(), id: \.key) { key, value in
                Text("\(key) = \(value)")
            }
            
            ForEach(dictComplex.ordered(), id: \.key) { key, value in
                Text("\(key) = \(value)")
            }

            ForEach(dictIntKeysEmpty.ordered(), id: \.key) { key, value in
                Text("\(key) = \(value)")
            }

            // simple Dictionary

            ForEach(Array(dictStrKeys.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).enumerated()), id: \.element.key) { index, element in
                Text("\(index): \(element.key) = \(element.value)")
            }

            ForEach(dictStrKeys.sorted(by: <), id: \.key) { key, value in
                Text("\(key) = \(value)")
            }

            ForEach(dictStrKeys.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                Text("\(key) = \(value)")
            }

            ForEach(Array(dictStrKeys), id: \.key) { key, value in
                Text("\(key) = \(value)")
            }

            ForEach(Array(dictStrKeys.keys), id: \.self) { key in
                if let value = dictStrKeys[key] {
                    Text("\(key) = \(value)")
                }
            }

            ForEach(Array(dictStrKeys.values), id: \.self) { value in
                Text("\(value)")
            }

            ForEach(Array(dictStrKeys.indices), id: \.self) { index in
                let key   = dictStrKeys[index].key
                let value = dictStrKeys[index].value
                Text("\(key) = \(value)")
            }

            // complex Dictionary

            ForEach(Array(dictComplex), id: \.key) { key, value in
                Text("BEST: \(key) = \(value.a):\(value.b)")
            }

            ForEach(Array(dictComplex.keys), id: \.self) { key in
                if let value = dictComplex[key] {
                    Text("\(key) = \(value.a):\(value.b)")
                }
            }

            ForEach(Array(dictComplex.values), id: \.self) { value in
                Text("\(value.a):\(value.b)")
            }

            ForEach(Array(dictComplex.indices), id: \.self) { index in
                let key   = dictComplex[index].key
                let value = dictComplex[index].value
                Text("\(key) = \(value.a):\(value.b)")
            }

        }}
    }

    init() {

        var time0 = CACurrentMediaTime()
        var time1 = CACurrentMediaTime()

        time0 = CACurrentMediaTime()
        for _ in 0...100000 {
            let _ = dictIntKeys.previous(before: 1)
            let _ = dictIntKeys.previous(before: 2)
            let _ = dictIntKeys.previous(before: 3)
        }
        time1 = CACurrentMediaTime()
        print("\(time0 - time1)")

        time0 = CACurrentMediaTime()
        for _ in 0...100000 {
            let _ = dictIntKeys.previousSlow(before: 1)
            let _ = dictIntKeys.previousSlow(before: 2)
            let _ = dictIntKeys.previousSlow(before: 3)
        }
        time1 = CACurrentMediaTime()
        print("\(time0 - time1)")

        /* ############################################################ */

        print("previous:")
        dump(dictIntKeys.previous(before: 1)  == nil)
        dump(dictIntKeys.previous(before: 2)! == (key: 1, value: "Item 1"))
        dump(dictIntKeys.previous(before: 3)! == (key: 2, value: "Item 2"))
        dump(dictIntKeys.previous(before: 4)! == (key: 2, value: "Item 2"))
        dump(dictIntKeys.previous(before: 5)! == (key: 4, value: "Item 4"))
        dump(dictIntKeys.previous(before: 6)! == (key: 5, value: "Item 5"))
        dump(dictIntKeys.previous(before: 7)! == (key: 5, value: "Item 5"))

        print("next:")
        dump(dictIntKeys.next(after: 1)! == (key: 2, value: "Item 2"))
        dump(dictIntKeys.next(after: 2)! == (key: 4, value: "Item 4"))
        dump(dictIntKeys.next(after: 3)! == (key: 4, value: "Item 4"))
        dump(dictIntKeys.next(after: 4)! == (key: 5, value: "Item 5"))
        dump(dictIntKeys.next(after: 5)  == nil)
        dump(dictIntKeys.next(after: 6)  == nil)

        print("previous (slow):")
        dump(dictIntKeys.previousSlow(before: 1)  == nil)
        dump(dictIntKeys.previousSlow(before: 2)! == (key: 1, value: "Item 1"))
        dump(dictIntKeys.previousSlow(before: 3)! == (key: 2, value: "Item 2"))
        dump(dictIntKeys.previousSlow(before: 4)! == (key: 2, value: "Item 2"))
        dump(dictIntKeys.previousSlow(before: 5)! == (key: 4, value: "Item 4"))
        dump(dictIntKeys.previousSlow(before: 6)! == (key: 5, value: "Item 5"))
        dump(dictIntKeys.previousSlow(before: 7)! == (key: 5, value: "Item 5"))

        print("next (slow):")
        dump(dictIntKeys.nextSlow(after: 1)! == (key: 2, value: "Item 2"))
        dump(dictIntKeys.nextSlow(after: 2)! == (key: 4, value: "Item 4"))
        dump(dictIntKeys.nextSlow(after: 3)! == (key: 4, value: "Item 4"))
        dump(dictIntKeys.nextSlow(after: 4)! == (key: 5, value: "Item 5"))
        dump(dictIntKeys.nextSlow(after: 5)  == nil)
        dump(dictIntKeys.nextSlow(after: 6)  == nil)

        print("last:")
        dump(dictIntKeys.last! == (key: 5, value: "Item 5"))
        dump(dictStrKeys.last! == (key: "key5", value: "value5"))
        dump(dictComplex.last! == (key: "key5", value: ComplexStruct(a: "value 5.1", b: "value 5.2")))
        dump(dictIntKeysEmpty.last == nil)

        print("Int keys (ordered):")
        for (key, value) in dictIntKeys.ordered() {
            print("\(key):\(value)")
        }

        print("Str keys (ordered):")
        for (key, value) in dictStrKeys.ordered() {
            print("\(key):\(value)")
        }

        print("Comples keys (ordered):")
        for (key, value) in dictComplex.ordered() {
            print("\(key):\(value)")
        }

        print("Empty:")
        for (key, value) in dictIntKeysEmpty.ordered() {
            print("\(key):\(value)")
        }

        dictIntKeys.append(
            "Item 6"
        )

        /* ############################################################ */

        print("Int keys (unknown order):")
        for (key, value) in dictIntKeys {
            print("\(key):\(value)")
        }

        print("Str keys (unknown order):")
        for (key, value) in dictStrKeys {
            print("\(key):\(value)")
        }

        print("Comples keys (unknown order):")
        for (key, value) in dictComplex {
            print("\(key):\(value)")
        }

        print("Empty (unknown order):")
        for (key, value) in dictIntKeysEmpty {
            print("\(key):\(value)")
        }

        /* ############################################################ */

        print("Str keys (enumerated):")
        for (i, item) in dictStrKeys.enumerated() {
            print("\(i) = \(item.key):\(item.value)")
        }

    }

}
