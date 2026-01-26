
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

extension AVAudioPlayerNode {

    func scheduleSegment(_ buffer: AVAudioPCMBuffer,
                           from: AVAudioFramePosition,
                           size: AVAudioFrameCount,
                           at: AVAudioTime?,
                           options: AVAudioPlayerNodeBufferOptions = [],
                           completionHandler: AVAudioNodeCompletionHandler? = nil) {
        self.scheduleBuffer(
            buffer.segmentGet(
                from: UInt64(from),
                size: UInt64(size))!,
            at: at,
            options: options,
            completionHandler: completionHandler
        )
    }

}
