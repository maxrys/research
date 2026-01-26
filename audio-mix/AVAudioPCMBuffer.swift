
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

extension AVAudioPCMBuffer {

    func segmentSet(_ data: AVAudioPCMBuffer, from: UInt64 = 0, size: UInt64? = nil) {
        let srcFullSize = UInt64(data.frameLength)
        let dstFullSize = UInt64(self.frameLength)
        var size = size ?? srcFullSize
        let from = from.fixBounds(max: dstFullSize)
            size = size.fixBounds(max: dstFullSize - from)
        for i in 0 ..< UInt64((Float(size) / Float(srcFullSize)).rounded(.up)) {
            let sampleSize = Int(data.format.streamDescription.pointee.mBytesPerFrame)
            let srcPointer = UnsafeMutableAudioBufferListPointer(data.mutableAudioBufferList)
            let dstPointer = UnsafeMutableAudioBufferListPointer(self.mutableAudioBufferList)
            let size = min(srcFullSize, size - (i * srcFullSize))
            let from =                  from + (i * srcFullSize)
            for (src, dst) in zip(srcPointer, dstPointer) {
                memcpy(
                    dst.mData?.advanced(by: Int(from) * sampleSize),
                    src.mData,
                    Int(size) * sampleSize
                )
            }
        }
    }

    static func etaloneGenerate(channels: UInt8 = 2, size: UInt64 = 1000) -> Self? {
        let avFormat = AVAudioFormat(
            commonFormat: AVAudioEngine.AV_DEFAULT_LINEAR_PCM_BIT_DEPTH_FORMAT,
            sampleRate  : AVAudioEngine.AV_DEFAULT_SAMPLERATE,
            channels    : AVAudioChannelCount(channels),
            interleaved : AVAudioEngine.AV_DEFAULT_IS_INTERLEAVED
        )!
        if let avBuffer = Self(pcmFormat: avFormat, frameCapacity: AVAudioFrameCount(size)) {
            avBuffer.frameLength = AVAudioFrameCount(size)
            let channelL = avBuffer.floatChannelData![0]
            let channelR = avBuffer.floatChannelData![1]
            for i in 0 ..< size {
                let sample: Float = Float(String(format: "%.3f", 0.001 * Float(i)))!
                if (channels >= 1) { channelL[Int(i) * avBuffer.stride] = (-1.0...1.0).contains(+sample) ? +sample : 0 }
                if (channels == 2) { channelR[Int(i) * avBuffer.stride] = (-1.0...1.0).contains(-sample) ? -sample : 0 }
            }
            return avBuffer
        }
        return nil
    }

}
