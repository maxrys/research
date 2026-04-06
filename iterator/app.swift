
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

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

        Task {
            for await value in AsyncCounter(3) {
                print("\(value)")
            }
        }

    }

}
