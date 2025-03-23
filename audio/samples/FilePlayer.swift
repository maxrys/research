
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

final class FilePlayer {

    private let avFile: AVAudioFile
    private let avBuffer: AVAudioPCMBuffer
    private let avEngine: AVAudioEngine
    private let avPlayerNode: AVAudioPlayerNode
    private var startingFrame: AVAudioFramePosition
    private let onStop: () -> Void

    var length: Int64 {
        Int64(self.avBuffer.frameLength)
    }

    var duration: Double {
        Double(self.length) / Double(self.rate)
    }

    var rate: Double {
        Double(self.avBuffer.format.sampleRate)
    }

    init?(_ fileURL: URL, engine: AVAudioEngine, onStop: @escaping () -> Void = {}) {
        do {
            self.avEngine = engine
            self.startingFrame = 0
            self.onStop = onStop
            self.avFile = try AVAudioFile(forReading: fileURL)
            self.avBuffer = try AVAudioPCMBuffer(file: avFile)!
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
        } catch {
            return nil
        }
    }

    private func prepareToPlay() {
        let startTime = AVAudioTime(
            sampleTime: -self.startingFrame,
            atRate: self.rate
        )
        self.avPlayerNode.scheduleBuffer(
            self.avBuffer,
            at: startTime,
            options: [],
            completionCallbackType: .dataPlayedBack,
            completionHandler: { _ in
                self.onStop()
            }
        )
    }

    func isPlaying() -> Bool {
        return self.avPlayerNode.isPlaying
    }

    func play(from startingFrame: AVAudioFramePosition) {
        self.startingFrame = startingFrame
        if (self.isPlaying()) { self.avPlayerNode.stop() }
        self.prepareToPlay()
        self.avPlayerNode.play()
    }

    func stop() {
        self.avPlayerNode.stop()
    }

}
