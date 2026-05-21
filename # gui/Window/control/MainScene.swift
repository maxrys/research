
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct MainScene: View {

    @Binding private var frame: CGRect

    init(_ frame: Binding<CGRect>) {
        self._frame = frame
    }

    var body: some View {
        VStack {

            HStack {
                Text("x").font(.headline)
                Button("←") { self.frame.x -= 10 }
                Button("→") { self.frame.x += 10 }
            }

            HStack {
                Text("y").font(.headline)
                Button("↑") { self.frame.y -= 10 }
                Button("↓") { self.frame.y += 10 }
            }

            HStack {
                Text("w").font(.headline)
                Button("←") { self.frame.w -= 10 }
                Button("→") { self.frame.w += 10 }
            }

            HStack {
                Text("h").font(.headline)
                Button("↑") { self.frame.h -= 10 }
                Button("↓") { self.frame.h += 10 }
            }

            Text("X = \(self.frame.x) : Y = \(self.frame.y)")
            Text("W = \(self.frame.w) : H = \(self.frame.h)")

        }.padding(40)
    }

}
