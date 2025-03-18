
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

final class TrackOscRenderer {

    typealias CheckPoint = (
        position: UInt64,
        state   : StateFX
    )

    static func render(track: TrackOsc, sample: AVAudioPCMBuffer) throws -> AVAudioPCMBuffer? {

        let sampleFormat = sample.format
        let sampleRatePerTertia = UInt32(
            sampleFormat.sampleRate / Double(TERTIA_PER_SECOND) /* 44100 ÷ 60 = 735 */
        )

        /* prepare data */
        let avBufferSrcLength = track.width * sampleRatePerTertia
        let avBufferSrc = AVAudioPCMBuffer(pcmFormat: sampleFormat, frameCapacity: avBufferSrcLength)!
        avBufferSrc.frameLength = avBufferSrcLength

        /* sample seeding */
        for cluster in track.clustersGet() {
            avBufferSrc.segmentSet(
                sample,
                from: UInt64((                        cluster.first!.timeStart) * sampleRatePerTertia),
                size: UInt64((cluster.last!.timeEnd - cluster.first!.timeStart) * sampleRatePerTertia)
            )
        }

        /* prepare checkpoints */
        var checkPoints: [CheckPoint] = [(position: 0, state: StateFX())]
        for note in track.notesOscSelect() {
            let positionBegin = UInt64(note.timeStart * sampleRatePerTertia)
            let positionEnd   = UInt64(note.timeEnd   * sampleRatePerTertia)
            if (checkPoints.last!.position != positionBegin) { checkPoints.append( (position: positionBegin, state: note.stateFX!) ) }
            if (checkPoints.last!.position != positionEnd  ) { checkPoints.append( (position: positionEnd  , state: note.stateFX!) ) }
        }

        /* prepare core audio */
        let avEngineLocal = AVAudioEngine()
        let avPlayerNode  = AVAudioPlayerNode()
        let avFx          = FXUnits()

        avEngineLocal.attach(avPlayerNode)
        avFx.link(
            engine    : avEngineLocal,
            playerNode: avPlayerNode,
            format    : avBufferSrc.format
        )

        avPlayerNode.scheduleBuffer(avBufferSrc)
        try avEngineLocal.enableManualRenderingMode(
            AVAudioEngineManualRenderingMode.offline,
            format           : avBufferSrc.format,
            maximumFrameCount: avBufferSrc.frameLength
        )
        try avEngineLocal.start()
        avPlayerNode.play()

        /* prepare output buffer */
        let buffer = AVAudioPCMBuffer(
            pcmFormat    : avEngineLocal.manualRenderingFormat,
            frameCapacity: avEngineLocal.manualRenderingMaximumFrameCount
        )!

        let result = AVAudioPCMBuffer(
            pcmFormat    : avBufferSrc.format,
            frameCapacity: avBufferSrc.frameCapacity
        )!

        result.frameLength = avBufferSrc.frameLength

        /* render */
        var checkPointPrevious = checkPoints.first!
        for checkPoint in checkPoints {
            if checkPoint.position == 0 {
                continue
            }
            avFx.stateApply(
                state: checkPoint.state
            )
            let size: UInt64 = checkPoint.position - checkPointPrevious.position
            let from: UInt64 =                       checkPointPrevious.position
            let renderResult = try avEngineLocal.renderOffline(
                AVAudioFrameCount(size),
                to: buffer
            )
            switch renderResult {
                case .success:
                    result.segmentSet(
                        buffer,
                        from: from,
                        size: size
                    )
                case .error                        : break
                case .insufficientDataFromInputNode: break
                case .cannotDoInCurrentContext     : break
                default                            : break
            }
            checkPointPrevious = checkPoint
        }

        avPlayerNode.stop()
        avEngineLocal.stop()
        return result
    }


}
