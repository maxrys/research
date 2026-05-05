
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

final class FieldValueState<T>: ObservableObject {

    @Published public var value: T {
        willSet { self.onChange(newValue) }
    }

    private let onChange: (T) -> Void

    init(_ value: T, _ onChange: @escaping (T) -> Void) {
        self.value    = value
        self.onChange = onChange
    }

}
