
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ProgressCustom: View {

    @Environment(\.colorScheme) private var colorScheme

    @Binding private var value: Double
    @State private var visibleFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    let height: CGFloat

    init(value: Binding<Double>, height: CGFloat = 30) {
        self._value = value
        self.height = height
    }

    var body: some View {
        let value = self.value.fixBounds(max: 1.0)
        let formattedValue = Int(value * 100)
        let width: CGFloat = visibleFrame.width * CGFloat(value)
        Color(self.colorScheme == .dark ? .black : .white).frame(height: self.height)
            .overlay(alignment: .leading) {
                Rectangle()
                    .fill(Color.blue.gradient)
                    .animation(.linear, value: value)
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
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 10) {
        ForEach(Array(stride(from: -0.1, through: 1.1, by: 0.1)), id: \.self) { value in
            ProgressCustom(
                value: Binding.constant(value)
            )
        }
    }
    .padding(10)
    .frame(width: 300)
}
