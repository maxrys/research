
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {
        }
    }

    init() {
        print("### TEST_ARRAYSAFE:")                  ; TestArray.test_arraySafe()                  ; print("")
        print("### TEST_ARRAYMATRIX:")                ; TestArray.test_arrayMatrix()                ; print("")
        print("### TEST_ARRAYMATRIX_ISTRIMON:")       ; TestArray.test_arrayMatrix_isTrimOn()       ; print("")
        print("### TEST_ARRAYMATRIX_RANDOM:")         ; TestArray.test_arrayMatrix_random()         ; print("")
        print("### TEST_ARRAYMATRIX_RANDOM_ISTRIMON:"); TestArray.test_arrayMatrix_random_isTrimOn(); print("")
    }

}
