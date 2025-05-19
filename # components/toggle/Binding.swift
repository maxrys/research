
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

extension Binding {

    func proxy(_ onChange: @escaping (_: Value, _: Value) -> Void = { _,_ in }) -> Binding<Value> {
        return Self(
            get: { self.wrappedValue },
            set: { newValue in
                let oldValue = self.wrappedValue
                self.wrappedValue = newValue
                onChange(oldValue, newValue)
            }
        )
    }

}

// class BindingToStateProxy<T> {
// 
//     lazy var value: Binding<T> = Binding<T>(
//         get: { self.value.wrappedValue },
//         set: { newValue in
//             self.value.wrappedValue = newValue
//         }
//     )
// 
//     var onChange: (T, T) -> Void
// 
//     init(value: Binding<T>, onChange: @escaping (T, T) -> Void = { _,_ in }) {
//         self.onChange = onChange
//     }
// 
// }
