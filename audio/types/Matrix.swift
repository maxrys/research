
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

final class Matrix<T> {

    typealias Value = [
        Level: [
            Level: T?
        ]
    ]

    private var matrix: Value = [:]

    func selectAll() -> Value {
        return self.matrix
    }

    subscript(levelX: Level, levelY: Level) -> T? {
        get {
            if let value = self.matrix[levelX]?[levelY]
                 { return value }
            else { return nil   }
        }
        set {
            if self.matrix[levelX] == nil { self.matrix[levelX] = [levelY:newValue] }
            if self.matrix[levelX] != nil { self.matrix[levelX]![levelY] = newValue }
        }
    }

}
