
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ProgressBar: View {

    let height: CGFloat = 20
    var value: Double

    init(value: Double) {
        self.value = value.fixBounds(max: 1.0)
    }

    var body: some View {
        GeometryReader { geometry in
            let width: CGFloat = self.value == 0 ? 1 : geometry.size.width * CGFloat(self.value)
            RoundedRectangle(cornerRadius: 5)
                .stroke(.black, lineWidth: 1)
                .fill(Color.blue)
                .frame(width: width, height: geometry.size.height)
                .animation(.linear, value: self.value)
                .overlay(alignment: .center) {
                    let formattedValue = Int(self.value * 100)
                    Text("\(formattedValue) %")
                        .foregroundStyle(.white)
                }
        }.frame(maxHeight: self.height)
    }

}



/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

#Preview {
    VStack(spacing: 10) {
        ProgressBar(value: -0.5)
        ProgressBar(value: +0.0)
        ProgressBar(value: +0.1)
        ProgressBar(value: +0.2)
        ProgressBar(value: +0.3)
        ProgressBar(value: +0.4)
        ProgressBar(value: +0.5)
        ProgressBar(value: +0.6)
        ProgressBar(value: +0.7)
        ProgressBar(value: +0.8)
        ProgressBar(value: +0.9)
        ProgressBar(value: +1.0)
        ProgressBar(value: +1.5)
    }
    .padding(10)
    .frame(width: 300)
}
