
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct VewPadPage: View {

    private let avEngine: AVAudioEngine
    private var bankCategories: [ModelCategories.ListItem] = []

    init(avEngine: AVAudioEngine) {
        self.avEngine = avEngine
        self.bankCategories = ModelCategories.selectList()
    }

    var body: some View {
        HStack (alignment: .top, spacing: 55) {
            ForEach(self.bankCategories.tuples, id: \.key) { (cIndex, category) in
                ForEach(category.banks.indices, id: \.self) { bankNum in
                    VStack(spacing: 5) {

                        let bank = ModelBanks.select(
                            bankID: category.banks[bankNum]
                        )

                        Text(
                            bank.isOscillator == true ?
                                "\(bank.title) | isOscillator" :
                                "\(bank.title)")
                        .font(.system(size: 12, weight: .bold))

                        Text("Category: \(category.title)")
                            .font(.system(size: 10, weight: .regular))

                        VStack {
                            ViewPad(
                                avEngine: self.avEngine,
                                cols    : bank.cols,
                                rows    : bank.rows,
                                samples : bank.samples
                            )
                        }
                        .padding(5)
                        .border(.black)

                    }
                }
            }
        }
    }

}
