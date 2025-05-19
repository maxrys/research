
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@Observable final class CustomState<T> {
    var wrappedValue: T
    init(_ value: T) {
        self.wrappedValue = value
    }
    func binding(_ onChange: @escaping (_: T, _: T) -> Void = { _,_ in }) -> Binding<T> {
        return Binding<T>(
            get: { self.wrappedValue },
            set: { newValue in
                let oldValue = self.wrappedValue
                self.wrappedValue = newValue
                onChange(oldValue, newValue)
            }
        )
    }
}

@main struct app: App {

    @State private var isOn_bState              : Bool = false
    @State private var isOn_sState              : Bool = false
    @State private var isOn_forProxy_state      : Bool = false
    @State private var isOn_originalToggle_state: Bool = false
           private var isOn_originalToggle_glState = CustomState<Bool>(false)

    var body: some Scene {
        WindowGroup {
            VStack(alignment: .leading) {

                let isFlexible = true

//                /* MARK: isOn = nil */
//                CustomToggle(text: "Custom Toggle (isOn = nil)", isFlexible: isFlexible) { isOn in
//                }
//
//                /* MARK: isOn = Bool */
//                CustomToggle(text: "Custom Toggle (isOn = Bool.true)", isFlexible: isFlexible, isOn: true) { isOn in
//                }
//
//                /* MARK: isOn = Binding.constant */
//                CustomToggle(text: "Custom Toggle (isOn = Binding.constant)", isFlexible: isFlexible, isOn: Binding.constant(true)) { isOn in
//                }
//
//                /* MARK: isOn = Binding */
//                CustomToggle(text: "Custom Toggle (isOn = Binding)", isFlexible: isFlexible, isOn: self.$isOn_bState) { isOn in
//                }
//
//                /* MARK: isOn = State */
//                CustomToggle(text: "Custom Toggle (isOn = State)", isFlexible: isFlexible, isOn: self.isOn_sState) { isOn in
//                    self.isOn_sState = isOn
//                }


                /* MARK: isOn = Binding Proxy */

                CustomToggle(text: "Custom Toggle (Binding Proxy)", isFlexible: isFlexible, isOn: self.$isOn_forProxy_state.proxy()) { isOn in
                    print("binding proxy: \(isOn)")
                }

                CustomToggle(text: "Custom Toggle (Binding Proxy)", isFlexible: isFlexible, isOn: self.$isOn_forProxy_state.proxy({ oldValue, newValue in
                    print("binding proxy: \(oldValue) → \(newValue)")
                }))

                CustomToggle(text: "Custom Toggle (Binding Proxy)", isFlexible: isFlexible, isOn: Binding<Bool>(
                    get: { self.isOn_forProxy_state },
                    set: { newValue in
                        self.isOn_forProxy_state = newValue
                        print("binding proxy (direct): \(newValue)")
                    }
                ))

                /* MARK: Original Toggle */

                Toggle("Original Toggle", isOn: self.$isOn_originalToggle_state)

                Toggle("Original Toggle", isOn: self.isOn_originalToggle_glState.binding())

                Toggle("Original Toggle", isOn: self.isOn_originalToggle_glState.binding({ oldValue, newValue in
                    print("binding proxy: \(oldValue) → \(newValue)")
                }))

                Toggle("Original Toggle", isOn: Binding<Bool>(
                    get: { self.isOn_originalToggle_glState.wrappedValue },
                    set: { newValue in
                        self.isOn_originalToggle_glState.wrappedValue = newValue
                        print("binding proxy (direct): \(newValue)")
                    }
                ))

            }.frame(maxWidth: 400)
        }
    }

    init() {

    }

}
