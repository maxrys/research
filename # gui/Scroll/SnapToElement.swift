
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct SnapToElement: View {

    var body: some View {
        ScrollView([.horizontal]) {
            HStack(spacing: 10) {
                ForEach(0 ..< 100, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .frame(width: 200, height: 150)
                        .overlay(
                            Text("Item \(index)").foregroundColor(.white)
                        )
                }
            }.scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .padding(10)
        .frame(width: 400)
    }

}

#Preview {
    SnapToElement()
}
