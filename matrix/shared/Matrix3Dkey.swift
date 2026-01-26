
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

struct Matrix3dKey: Equatable {

    typealias Index = UInt16
    typealias Value = UInt64

    var z: Index
    var y: Index
    var x: Index

    init(z: Index, y: Index, x: Index) {
        self.z = z
        self.y = y
        self.x = x
    }

    init(decodeFrom value: Value) {
        self.z = Index(value >> (Index.bitWidth * 2) & Value(Index.max))
        self.y = Index(value >> (Index.bitWidth    ) & Value(Index.max))
        self.x = Index(value                         & Value(Index.max))
    }

    var value: Value {
        (Value(self.z) << (Index.bitWidth * 2)) |
        (Value(self.y) << (Index.bitWidth    )) |
        (Value(self.x)                        )
    }

}
