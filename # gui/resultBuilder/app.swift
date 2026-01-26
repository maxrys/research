
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        WindowGroup {
            Container {
                Text("Child 1 AnyView content")
                Text("Child 2 AnyView content")
                Text("Child 3 AnyView content")
                Color.red.frame(width: 10, height: 10)
            }.padding(20)

            ParentContainer {
                ChildContainer(title: "Child 1") { Text("Child 1 AnyView content") }
                ChildContainer(title: "Child 2") { Text("Child 2 AnyView content") }
                ChildContainer(title: "Child 3") { Text("Child 3 AnyView content") }
            }.padding(20)
        }
    }

}
