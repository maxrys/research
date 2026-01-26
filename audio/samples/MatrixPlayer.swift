
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

final class MatrixPlayer {

    private let avBuffer: AVAudioPCMBuffer
    private let avEngine: AVAudioEngine
    private let avPlayerNode: AVAudioPlayerNode
    private let loopMode: LoopMode
    private let onStop: () -> Void

    init(buffer: AVAudioPCMBuffer, engine: AVAudioEngine, loopMode: LoopMode = .once, onStop: @escaping () -> Void = {}) {
        self.avBuffer = buffer
        self.avEngine = engine
        self.loopMode = loopMode
        self.onStop = onStop
        self.avPlayerNode = AVAudioPlayerNode()
        self.avEngine.attach(self.avPlayerNode)
        self.avEngine.connect(
                    self.avPlayerNode,
                to: self.avEngine.mainMixerNode,
            format: self.avBuffer.format
        )
        if self.avEngine.isRunning == false {
            try! self.avEngine.start()
        }
    }

    private func prepareToPlay() {
        self.avPlayerNode.scheduleBuffer(
            self.avBuffer,
            at: nil,
            options: self.loopMode == .loop ? .loops : [],
            completionCallbackType: .dataConsumed,
            completionHandler: { _ in
                self.onStop()
            }
        )
    }

    func isPlaying() -> Bool {
        return self.avPlayerNode.isPlaying
    }

    func play() {
        if (self.isPlaying()) { self.avPlayerNode.stop() }
        self.prepareToPlay()
        self.avPlayerNode.play()
    }

    func stop() {
        if (self.loopMode == .once) { /* wait until finished */ }
        if (self.loopMode == .loop) {
            self.avPlayerNode.stop()
        }
    }

}
