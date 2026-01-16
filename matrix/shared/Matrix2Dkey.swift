
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

struct Matrix2dKey: Equatable {

    typealias Index = UInt32
    typealias Value = UInt64

    var y: Index
    var x: Index

    init(y: Index, x: Index) {
        self.y = y
        self.x = x
    }

    init(decodeFrom value: Value) {
        self.y = Index(value >> Index.bitWidth & Value(Index.max))
        self.x = Index(value                   & Value(Index.max))
    }

    var value: Value {
        (Value(self.y) << Index.bitWidth) | Value(self.x)
    }

}
