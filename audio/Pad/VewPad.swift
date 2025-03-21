
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct ViewPad: View {

    private let avEngine: AVAudioEngine
    private var cols: Level = 1
    private var rows: Level = 1
    private var playersMatrix: Matrix = Matrix<MatrixPlayer>()

    init(avEngine: AVAudioEngine, cols: Level, rows: Level, samples: [String: ModelBanks.SampleInfo]) {
        self.avEngine = avEngine
        self.cols     = cols
        self.rows     = rows
        for sample in samples.values {
            self.playersMatrix[sample.levelX, sample.levelY] = MatrixPlayer(
                buffer  : sample.buffer,
                engine  : self.avEngine,
                loopMode: sample.loopMode
            )
        }
    }

    var body: some View {
        Grid(alignment: .bottomLeading, horizontalSpacing: 3, verticalSpacing: 3) {
            ForEach((1...self.rows).reversed(), id: \.self) { y in
                GridRow {
                    ForEach(1...self.cols, id: \.self) { x in
                        ViewPadCell(
                            label: "\(x):\(y)",
                            onChange: self.onChange,
                            settings: [
                                "levelX": x,
                                "levelY": y
                            ]
                        )
                    }
                }
            }
        }
    }

    func onChange(element: ViewPadCell) {
        if let levelX = element.settings["levelX"],
           let levelY = element.settings["levelY"] {
            if let player = self.playersMatrix[Level(levelX), Level(levelY)] {
                if (element.isOn) { player.play() }
                else              { player.stop() }
            }
        }
    }

}
