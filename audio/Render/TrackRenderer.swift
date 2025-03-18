
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

final class TrackRenderer {

    typealias CheckPoint = (
        position: UInt64,
        state   : StateFX
    )

    enum RenderError: Error {

        case error
        case insufficientDataFromInputNode
        case cannotDoInCurrentContext
        case byDefault

    }

    static func render(track: Track, samples: Matrix<AVAudioPCMBuffer>) throws -> AVAudioPCMBuffer? {

        let sampleFormat = samples[1, 1]!.format
        let sampleRatePerTertia = UInt32(
            sampleFormat.sampleRate / Double(TERTIA_PER_SECOND) /* 44100 ÷ 60 = 735 */
        )

        /* prepare data */
        let avBufferSrcLength = track.width * sampleRatePerTertia
        let avBufferSrc = AVAudioPCMBuffer(pcmFormat: sampleFormat, frameCapacity: avBufferSrcLength)!
        avBufferSrc.frameLength = avBufferSrcLength

        /* sample seeding */
        for note in track.notesSelect() {
            if let sample = samples[note.levelX, note.levelY] {
                avBufferSrc.segmentSet(
                    sample,
                    from: UInt64((               note.timeStart) * sampleRatePerTertia),
                    size: UInt64((note.timeEnd - note.timeStart) * sampleRatePerTertia)
                )
            }
        }

        return avBufferSrc
    }

}
