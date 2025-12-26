
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Container: View {

    private let contents: [any View]

    init(@ViewBuilderArrayAny content: () -> [any View]) {
        self.contents = content()
    }

    public var body: some View {
        VStack {
            ForEach(0 ..< self.contents.count, id: \.self) { index in
                if let child = self.contents[safe: index] {
                    AnyView(child)
                }
            }
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    Container {
        Text("Child 1 AnyView content")
        Text("Child 2 AnyView content")
        Text("Child 3 AnyView content")
        Color.red.frame(width: 10, height: 10)
    }.padding(20)
}
