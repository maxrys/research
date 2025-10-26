
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        Window("Main", id: "main") {
            VStack {
                Text("RegExp")
            }
        }
    }

    init() {

        let string = "abcde.12345"
        let regex = try! NSRegularExpression(pattern: "^" + "(?<letters>[a-z]+)" + "\\." + "(?<numbers>[0-9]+)" + "$")
        let regexMatches = regex.findInGroups(in: string, groups: ["letters", "numbers"])
        dump(regexMatches["letters"]!)
        dump(regexMatches["numbers"]!)

    }

}
