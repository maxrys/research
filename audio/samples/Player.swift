
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

final class Player {

    private let avBuffer: AVAudioPCMBuffer
    private let avEngine: AVAudioEngine
    private let avPlayerNode: AVAudioPlayerNode
    private var startingFrame: AVAudioFramePosition
    private var isPlaying: Bool
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

    var getLastRenderFrame: AVAudioFramePosition {
        if (self.isPlaying) {
            if let lastRenderTime = self.avPlayerNode.lastRenderTime {
                if let playerTime = self.avPlayerNode.playerTime(forNodeTime: lastRenderTime) {
                    return (self.startingFrame + playerTime.sampleTime).fixBounds(
                        max: self.length
                    )
                }
            }
        }
        return self.startingFrame
    }

    func setStartingFrame(_ startingFrame: AVAudioFramePosition) {
        self.startingFrame = startingFrame.fixBounds(
            max: self.length
        )
    }

    convenience init?(_ fileURL: URL, engine: AVAudioEngine, onStop: @escaping () -> Void = {}) {
        do {
            self.init(
                try AVAudioPCMBuffer(file: try AVAudioFile(forReading: fileURL))!,
                engine: engine,
                onStop: onStop
            )
        } catch {
            return nil
        }
    }

    init(_ buffer: AVAudioPCMBuffer, engine: AVAudioEngine, onStop: @escaping () -> Void = {}) {
        self.avBuffer = buffer
        self.avEngine = engine
        self.onStop = onStop
        self.startingFrame = 0
        self.isPlaying = false
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
        let startTime = AVAudioTime(
            sampleTime: -self.startingFrame,
            atRate    :  self.rate
        )
        self.avPlayerNode.scheduleBuffer(
            self.avBuffer,
            at: startTime,
            options: [],
            completionCallbackType: .dataPlayedBack,
            completionHandler: { _ in
                self.isPlaying = false
                self.onStop()
                self.setStartingFrame(0)
            }
        )
    }

    func play() {
        self.avPlayerNode.stop()
        self.prepareToPlay()
        self.isPlaying = true
        self.avPlayerNode.play()
    }

    func stop() {
        self.avPlayerNode.stop()
    }

}
