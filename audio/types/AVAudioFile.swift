
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

extension AVAudioFile {

    func getInfo() -> (format: AVAudioFormat,
                       samplesLength: AVAudioFramePosition,
                       sampleRate: Double,
                       lengthInSeconds: Double) {
        let format = self.processingFormat
        let samplesLength = self.length
        let sampleRate = format.sampleRate
        let lengthInSeconds = Double(samplesLength) / sampleRate
        return (
            format         : format,
            samplesLength  : samplesLength,
            sampleRate     : sampleRate,
            lengthInSeconds: lengthInSeconds
        )
    }

}
