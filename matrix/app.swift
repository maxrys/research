
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
        print("### ARRAY SAFE INDEX:")                     ; TestArray.test_arraySafeIndex()                 ; print("")
        print("### ARRAY MATRIX:")                         ; TestArray.test_arrayMatrix()                    ; print("")
        print("### ARRAY MATRIX (IS TRIM ON):")            ; TestArray.test_arrayMatrix_isTrimOn()           ; print("")
        print("### ARRAY MATRIX RANDOM SEED:")             ; TestArray.test_arrayMatrix_randomSeed()         ; print("")
        print("### ARRAY MATRIX RANDOM SEED (IS TRIM ON):"); TestArray.test_arrayMatrix_randomSeed_isTrimOn(); print("")
    }

}
