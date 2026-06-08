
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ViewFramePreferenceKey: @MainActor PreferenceKey {
    @MainActor static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {

    func trackFrameOnScreen(onChange: @escaping (CGRect) -> Void) -> some View {
        self.background(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: ViewFramePreferenceKey.self,
                        value: geometry.frame(
                            in: .global
                        )
                    )
            }
        ).onPreferenceChange(
            ViewFramePreferenceKey.self,
            perform: onChange
        )
    }

}
