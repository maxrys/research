
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

extension AVAudioEngine {

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

}
