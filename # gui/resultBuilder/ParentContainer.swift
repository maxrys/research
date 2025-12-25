
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ParentContainer: View {

    private let contents: [ChildContainer]

    init(@ViewBuilderArray<ChildContainer> content: () -> [ChildContainer]) {
        self.contents = content()
    }

    public var body: some View {
        VStack {
            ForEach(0 ..< self.contents.count, id: \.self) { index in
                if let child = self.contents[safe: index] {
                    Text(child.title).font(.headline)
                    child
                }
            }
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    ParentContainer {
        ChildContainer(title: "Child 1") { Text("Child 1 AnyView content") }
        ChildContainer(title: "Child 2") { Text("Child 2 AnyView content") }
        ChildContainer(title: "Child 3") { Text("Child 3 AnyView content") }
    }.padding(20)
}
