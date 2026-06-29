
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension String {

    func addPrefixIfMissing(_ prefix: String) -> String {
        self.hasPrefix(prefix) ? self : prefix + self
    }

    func addSuffixIfMissing(_ suffix: String) -> String {
        self.hasSuffix(suffix) ? self : self + suffix
    }

}
