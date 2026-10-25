
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

struct CellIDValue: Equatable {

    typealias Index = UInt8
    typealias Raw = UInt16

    var rowNum: Index
    var colNum: Index

    init(rowNum: Index, colNum: Index) {
        self.rowNum = rowNum
        self.colNum = colNum
    }

    init(decodeFrom value: Raw) {
        self.rowNum = Index(value >> Index.bitWidth & Raw(Index.max))
        self.colNum = Index(value                   & Raw(Index.max))
    }

    var raw: Raw {
        (Raw(self.rowNum) << Index.bitWidth) | Raw(self.colNum)
    }

}
