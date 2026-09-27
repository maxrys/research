
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PreviewMode: View {

    @ObservedObject private var state: ValueState<UInt>
    private let title:  String?
    private let modes: [String]

    init(title: String? = nil, state: ValueState<UInt>, modes: [String]) {
        self.title = title
        self.state = state
        self.modes = modes
    }

    var body: some View {
        VStack(spacing: 10) {
            if let title = self.title {
                Text(title)
                    .font(.headline)
            }
            HStack(spacing: 0) {
                ForEach(self.modes.indices, id: \.self) { index in
                    self.ButtonView(
                        index: UInt(index)
                    )
                }
            }
            .padding(5)
            .background(Color.black.opacity(0.05))
            .clipShape(Capsule())
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }

    @ViewBuilder func ButtonView(index: UInt) -> some View {
        Button {
            self.state.value = index
        } label: {
            let isActive = self.state.value == index
            Text(self.modes[Int(index)])
                .padding(.horizontal, 10)
                .padding(.vertical  ,  5)
                .foregroundPolyfill(
                    isActive ?
                        Color.white :
                        Color.black
                )
                .background(
                    Capsule()
                        .fill(isActive ?
                            Color.blue :
                            Color.clear
                        )
                )
                .clipShape   (Capsule())
                .contentShape(Capsule())
                .focusEffect (Capsule())
        }
        .focusable(false)
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

}
