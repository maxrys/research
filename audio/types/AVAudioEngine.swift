
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

extension AVAudioEngine {

    static let AV_RENDER_STEP = 1024
    static let AV_DEFAULT_LINEAR_PCM_BIT_DEPTH_FORMAT: AVAudioCommonFormat = .pcmFormatFloat32
    static let AV_DEFAULT_SAMPLERATE: Double = 44100.0
    static let AV_DEFAULT_CHANNELS: AVAudioChannelCount = 2
    static let AV_DEFAULT_IS_INTERLEAVED: Bool = false
    static let AV_DEFAULT_FORMAT = AVAudioFormat(
        commonFormat: AV_DEFAULT_LINEAR_PCM_BIT_DEPTH_FORMAT,
        sampleRate  : AV_DEFAULT_SAMPLERATE,
        channels    : AV_DEFAULT_CHANNELS,
        interleaved : AV_DEFAULT_IS_INTERLEAVED
    )!

    public func mix(_ avBuffers: [AVAudioPCMBuffer], resultFormat: AVAudioFormat? = nil) -> AVAudioPCMBuffer? {
        do {
            var avPlayerNodes: [AVAudioPlayerNode] = []
            var frameLength: AVAudioFrameCount = 0
            for avBuffer in avBuffers {
                let avPlayerNode = AVAudioPlayerNode()
                avPlayerNodes.append(avPlayerNode)
                self.attach(avPlayerNode)
                self.connect(
                            avPlayerNode,
                        to: self.mainMixerNode,
                    format: avBuffer.format
                )
                avPlayerNode.scheduleBuffer(avBuffer)
                frameLength = max(
                    frameLength,
                    avBuffer.frameLength
                )
            }
            try self.enableManualRenderingMode(
                AVAudioEngineManualRenderingMode.offline,
                format           : resultFormat ?? Self.AV_DEFAULT_FORMAT,
                maximumFrameCount: frameLength
            )
            try self.start()
            defer {
                self.stop()
            }
            for node in avPlayerNodes {
                node.play()
            }
            let buffer = AVAudioPCMBuffer(
                pcmFormat    : self.manualRenderingFormat,
                frameCapacity: self.manualRenderingMaximumFrameCount
            )!
            let result = AVAudioPCMBuffer(
                pcmFormat    : resultFormat ?? Self.AV_DEFAULT_FORMAT,
                frameCapacity: frameLength
            )!
            result.frameLength = frameLength
            for from in stride(from: 0, to: frameLength, by: Self.AV_RENDER_STEP) {
                let renderResult = try self.renderOffline(
                    AVAudioFrameCount(Self.AV_RENDER_STEP),
                    to: buffer
                )
                switch renderResult {
                    case .success:
                        result.segmentSet(
                            buffer,
                            from: UInt64(from),
                            size: UInt64(Self.AV_RENDER_STEP)
                        )
                    case .error                        : return nil
                    case .insufficientDataFromInputNode: return nil
                    case .cannotDoInCurrentContext     : return nil
                    default                            : return nil
                }
            }
            for node in avPlayerNodes {
                node.stop()
            }
            return result
        } catch {
            return nil
        }
    }

}
