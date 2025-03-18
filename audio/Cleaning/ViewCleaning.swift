
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct ViewCleaning: View {

    private let avEngine: AVAudioEngine

    init(avEngine: AVAudioEngine) {
        self.avEngine = avEngine
    }

    var body: some View {
        VStack {
            Text("Cleaning")
                .font(.system(size: 12, weight: .bold))

            VStack {
                Button { run() } label: { Text("run").frame(width: 50) }
            }
        }
    }

    func run() {
        do {

            let avFileSrc = try AVAudioFile(forReading: FILE_URL_PIANO)
            let avBuffer = try AVAudioPCMBuffer(file: avFileSrc)!

            let avFileDst = try AVAudioFile(
                forWriting  : URL(filePath: FILE_PATH_RESULT),
                settings    : avBuffer.format.settings,
                commonFormat: avBuffer.format.commonFormat,
                interleaved : avBuffer.format.isInterleaved
            )

            try avFileDst.write(from: avBuffer)
            avFileDst.close()

        } catch {
            print("Error: \(error).")
        }
    }

}
