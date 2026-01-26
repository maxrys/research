
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct ViewPlayPage: View {

    private let avEngine: AVAudioEngine

    init(avEngine: AVAudioEngine) {
        self.avEngine = avEngine
    }

    var body: some View {
        VStack {

            Text("Play")
                .font(.system(size: 12, weight: .bold))

            VStack {
                Button { self.avPlayer()                        } label: { Text("avPlayer")                            .frame(width: 250) }
                Button { self.avAudioUnitSampler()              } label: { Text("avAudioUnitSampler")                  .frame(width: 250) }
                Button { self.avFile_scheduleFile()             } label: { Text("avFile → scheduleFile")               .frame(width: 250) }
                Button { self.avFile_avBuffer_scheduleBuffer()  } label: { Text("avFile → avBuffer → scheduleBuffer")  .frame(width: 250) }
                Button { self.avFile_scheduleSegment()          } label: { Text("avFile → scheduleSegment")            .frame(width: 250) }
                Button { self.avFile_avBuffer_scheduleSegment() } label: { Text("avFile → avBuffer → scheduleSegment") .frame(width: 250) }
            }

        }
    }

    static var AV_PLAYER = AVAudioPlayer()

    func avPlayer() {
        Self.AV_PLAYER = try! AVAudioPlayer(
            contentsOf: FILE_URL_PIANO
        )
        if Self.AV_PLAYER.isPlaying { Self.AV_PLAYER.pause() }
        else                        { Self.AV_PLAYER.play() }
    }

    func avAudioUnitSampler() {
        let avSampler = AVAudioUnitSampler()
        try! avSampler.loadAudioFiles(
            at: [FILE_URL_PIANO]
        )

        self.avEngine.attach(avSampler)
        self.avEngine.connect(
            avSampler,
            to    : self.avEngine.mainMixerNode,
            format: self.avEngine.mainMixerNode.outputFormat(
                forBus: 0
            )
        )
        if self.avEngine.isRunning == false {
            try! self.avEngine.start()
        }

        avSampler.startNote(60, withVelocity: 255, onChannel: 0)
    }

    func avFile_scheduleFile() {
        let avFile = try! AVAudioFile(forReading: FILE_URL_PIANO)
        let avPlayerNode = AVAudioPlayerNode()

        self.avEngine.attach(avPlayerNode)
        self.avEngine.connect(
            avPlayerNode,
            to    : self.avEngine.mainMixerNode,
            format: avFile.processingFormat
        )
        if self.avEngine.isRunning == false {
            try! self.avEngine.start()
        }

        avPlayerNode.scheduleFile(avFile, at: nil)
        avPlayerNode.play()
    }

    func avFile_avBuffer_scheduleBuffer() {
        let avFile = try! AVAudioFile(forReading: FILE_URL_PIANO)
        let avBuffer = try! AVAudioPCMBuffer(file: avFile)!
        let avPlayerNode = AVAudioPlayerNode()

        self.avEngine.attach(avPlayerNode)
        self.avEngine.connect(
            avPlayerNode,
            to    : self.avEngine.mainMixerNode,
            format: avFile.processingFormat
        )
        if self.avEngine.isRunning == false {
            try! self.avEngine.start()
        }

        avPlayerNode.scheduleBuffer(avBuffer)
        avPlayerNode.play()
    }

    func avFile_scheduleSegment() {
        let avFile = try! AVAudioFile(forReading: FILE_URL_PIANO)
        let avPlayerNode = AVAudioPlayerNode()

        self.avEngine.attach(avPlayerNode)
        self.avEngine.connect(
            avPlayerNode,
            to    : self.avEngine.mainMixerNode,
            format: avFile.processingFormat
        )
        if self.avEngine.isRunning == false {
            try! self.avEngine.start()
        }

        avPlayerNode.scheduleSegment(
            avFile,
            startingFrame: AVAudioFramePosition(0),
            frameCount: AVAudioFrameCount(5000),
            at: nil,
            completionCallbackType: .dataPlayedBack,
            completionHandler: { _ in
            }
        )

        avPlayerNode.play()
    }

    func avFile_avBuffer_scheduleSegment() {
        let avFile = try! AVAudioFile(forReading: FILE_URL_PIANO)
        let avBuffer = try! AVAudioPCMBuffer(file: avFile)!
        let avPlayerNode = AVAudioPlayerNode()

        self.avEngine.attach(avPlayerNode)
        self.avEngine.connect(
            avPlayerNode,
            to    : self.avEngine.mainMixerNode,
            format: avFile.processingFormat
        )
        if self.avEngine.isRunning == false {
            try! self.avEngine.start()
        }

        avPlayerNode.scheduleSegment(
            avBuffer,
            from: 0,
            size: 5000,
            at: nil,
            options: [] // .loops
        )

        avPlayerNode.play()
    }

}
