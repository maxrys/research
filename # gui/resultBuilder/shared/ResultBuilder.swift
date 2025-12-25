
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

@resultBuilder struct ViewBuilderArray<T> {

    static func buildBlock(_ components: T...) -> [T] {
        components
    }

}
