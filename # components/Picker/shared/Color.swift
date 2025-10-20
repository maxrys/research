
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

/* Picker Custom */

extension Color {

    typealias _PickerPropSignature = (
        text          : Self,
        border        : Self,
        background    : Self,
        itemText      : Self,
        itemBackground: Self,
    )

    static var picker: (_PickerPropSignature) {(
        text          : Self("color PickerCustom Text"),
        border        : Self("color PickerCustom Border"),
        background    : Self("color PickerCustom Background"),
        itemText      : Self("color PickerCustom Item Text"),
        itemBackground: Self("color PickerCustom Item Background"),
    )}

}
