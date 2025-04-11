
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct app: App {

    var body: some Scene {
        WindowGroup {
            Text("JSON")
        }
    }

    init() {
        print(""); print("test_JSONSerialization():");     test_JSONSerialization()
        print(""); print("test_JSONEncoder():");           test_JSONEncoder()
        print(""); print("test_JSONEncoder_AnyObject():"); test_JSONEncoder_AnyObject()
        print(""); print("test_JSONDecoder():");           test_JSONDecoder()
    }

}
