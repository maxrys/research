
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {
            Text("JSON")
        }
    }

    init() {
        print(""); print("test_JSONSerialization():"); test_JSONSerialization()
        print(""); print("test_JSONEncoder():");       test_JSONEncoder()
        print(""); print("test_JSONDecoder():");       test_JSONDecoder()
        print(""); print("test_jsBlockerRules_JSONSerialization():"); test_jsBlockerRules_JSONSerialization()
        print(""); print("test_jsBlockerRules_JSONEncoder():");       test_jsBlockerRules_JSONEncoder()
    }

}
