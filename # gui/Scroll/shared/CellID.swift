
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

struct CellID: Equatable {

    typealias Value = UInt16

    var colNum: GridAxisIndex
    var rowNum: GridAxisIndex

    init(colNum: GridAxisIndex, rowNum: GridAxisIndex) {
        self.colNum = colNum
        self.rowNum = rowNum
    }

    init(decodeFrom value: Value) {
        self.colNum = GridAxisIndex(value >> 8 & 0xff)
        self.rowNum = GridAxisIndex(value      & 0xff)
    }

    var value: Value {
        (Value(self.colNum) << 8) | Value(self.rowNum)
    }

}
