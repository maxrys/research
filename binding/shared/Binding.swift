
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

extension Binding {

    func proxy(_ onChange: @escaping (_: Value) -> Void = { _ in }) -> Binding<Value> {
        return Self(
            get: {          self.wrappedValue                          },
            set: { value in self.wrappedValue = value; onChange(value) }
        )
    }

}
