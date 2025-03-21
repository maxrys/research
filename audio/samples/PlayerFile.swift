
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

final class PlayerFile {

    private let avFile: AVAudioFile
    private let avEngine: AVAudioEngine
    private let avPlayerNode: AVAudioPlayerNode
    private var startingFrame: AVAudioFramePosition
    private var frameCount: AVAudioFrameCount
    private let onStop: () -> Void

    var length: Int64 {
        self.avFile.length
    }

    var duration: Double {
        Double(self.length) / Double(self.rate)
    }

    var rate: Double {
        Double(self.avFile.fileFormat.sampleRate)
    }

    init?(_ fileURL: URL, engine: AVAudioEngine, onStop: @escaping () -> Void = {}) {
        do {
            self.avEngine = engine
            self.startingFrame = 0
            self.onStop = onStop
            self.avFile = try AVAudioFile(forReading: fileURL)
            self.frameCount = AVAudioFrameCount(avFile.length)
            self.avPlayerNode = AVAudioPlayerNode()
            self.avEngine.attach(self.avPlayerNode)
            self.avEngine.connect(
                        self.avPlayerNode,
                    to: self.avEngine.mainMixerNode,
                format: self.avFile.processingFormat
            )
            if self.avEngine.isRunning == false {
                try! self.avEngine.start()
            }
        } catch {
            return nil
        }
    }

    private func prepareToPlay() {
        self.avPlayerNode.scheduleSegment(
            self.avFile,
            startingFrame: self.startingFrame,
            frameCount: self.frameCount,
            at: nil,
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
        self.frameCount = AVAudioFrameCount(self.length - self.startingFrame)
        if (self.isPlaying()) { self.avPlayerNode.stop() }
        self.prepareToPlay()
        self.avPlayerNode.play()
    }

    func stop() {
        self.avPlayerNode.stop()
    }

}
