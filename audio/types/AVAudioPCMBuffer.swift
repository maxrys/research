
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

extension AVAudioPCMBuffer {

    public var realSize: UInt64 {
        get {
            let channels = Int(self.format.channelCount)
            let size = Int(self.frameLength)
            var realSize = size
            for i in (0 ..< size).reversed() {
                var isStillEmpty = true
                for channel in 0 ..< channels {
                    let value = self.floatChannelData?[channel][i * self.stride] ?? 0.0
                    if (value != 0.0) {
                        isStillEmpty = false
                    }
                }
                if (isStillEmpty == true) { realSize -= 1 }
                if (isStillEmpty != true) { break }
            }
            return UInt64(
                realSize
            )
        }
    }

    convenience init?(file: AVAudioFile) throws {
        file.framePosition = 0
        self.init(
            pcmFormat    : file.processingFormat,
            frameCapacity: AVAudioFrameCount(file.length)
        )
        try file.read(
            into: self
        )
    }

    func segmentGet(from: UInt64 = 0, size: UInt64 = UInt64.max) -> Self? {
        let from = from.fixBounds(max: UInt64(self.frameLength))
        let size = size.fixBounds(max: UInt64(self.frameLength) - from)
        let data = Self(
            pcmFormat    : self.format,
            frameCapacity: AVAudioFrameCount(size)
        )!
        let sampleSize = Int(self.format.streamDescription.pointee.mBytesPerFrame)
        let srcPointer = UnsafeMutableAudioBufferListPointer(self.mutableAudioBufferList)
        let dstPointer = UnsafeMutableAudioBufferListPointer(data.mutableAudioBufferList)
        for (src, dst) in zip(srcPointer, dstPointer) {
            memcpy(
                dst.mData,
                src.mData?.advanced(by: Int(from) * sampleSize),
                Int(size) * sampleSize
            )
        }
        data.frameLength = AVAudioFrameCount(size)
        return data
    }

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

    func floatMatrixGet() -> [[Float]] {
        var result:[[Float]] = Array(
            repeating: Array(
                repeating: Float(0.0),
                count    : Int(self.frameLength) ),
            count: Int(self.format.channelCount)
        )
        for channel in 0 ..< Int(self.format.channelCount) {
            for i in 0 ..< Int(self.frameLength) {
                result[channel][i * self.stride] = self.floatChannelData?[channel][i * self.stride] ?? 0.0
            }
        }
        return result
    }

    func floatMatrixGet(from: UInt64 = 0, size: UInt64 = UInt64.max) -> [[Float]] {
        let from = from.fixBounds(max: UInt64(self.frameLength))
        let size = size.fixBounds(max: UInt64(self.frameLength) - from)
        var result:[[Float]] = Array(
            repeating: Array(
                repeating: Float(0.0),
                count    : Int(size)),
            count: Int(self.format.channelCount)
        )
        for channel in 0 ..< Int(self.format.channelCount) {
            for i in Int(from) ..< Int(from + size) {
                let position = i * self.stride
                if (position < self.frameLength)
                     { result[channel][position - Int(from)] = self.floatChannelData?[channel][position] ?? 0.0 }
                else { result[channel][position - Int(from)] =                                              0.0 }
            }
        }
        return result
    }

    func floatMatrixSet(_ data: [[Float]], from: UInt64 = 0, size: UInt64? = nil) {
        var size = size ?? UInt64(data.first!.count)
        let from = from.fixBounds(max: UInt64(self.frameLength))
            size = size.fixBounds(max: UInt64(self.frameLength) - from)
        for (chanelNum, chanelData) in data.enumerated() {
            if (chanelNum < self.format.channelCount) {
                if let channel = self.floatChannelData?[chanelNum] {
                    for i in Int(from) ..< Int(from + size) {
                        channel[i] = chanelData[
                            (i - Int(from)) % chanelData.count
                        ]
                    }
                }
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
