
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ProgressCustom: View {

    @Environment(\.colorScheme) private var colorScheme
    @State private var visibleFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    let height: CGFloat = 30
    var value: Double

    init(value: Double) {
        self.value = value.fixBounds(max: 1.0)
    }

    var body: some View {
        let formattedValue = Int(self.value * 100)
        let width: CGFloat = visibleFrame.width * CGFloat(self.value)
        Color(self.colorScheme == .dark ? .black : .white).frame(height: self.height)
            .overlay(alignment: .leading) {
                Rectangle()
                    .fill(Color.blue.gradient)
                    .animation(.linear, value: self.value)
                    .frame(width: width)
            }.overlay(alignment: .center) {
                Text("\(formattedValue) %")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.blue)
                    .blendMode(.difference)
            }
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .onGeometryChange(for: CGSize.self) { geometry in geometry.size } action: { size in
            self.visibleFrame.size = size
        }
    }

}



/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

#Preview {
    VStack(spacing: 10) {
        ForEach(Array(stride(from: -0.1, through: 1.1, by: 0.1)), id: \.self) { value in
            ProgressCustom(value: value)
        }
    }
    .padding(10)
    .frame(width: 300)
}
