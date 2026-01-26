
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct ViewGenerate: View {

    static let AV_LINEAR_PCM_BIT_DEPTH_FORMAT: AVAudioCommonFormat = .pcmFormatFloat32
    static let AV_SAMPLERATE = 44100.0
    static let AV_CHANNELS: AVAudioChannelCount = 1
    static let AV_IS_INTERLEAVED: Bool = false

    static let AV_CARRIER_FREQUENCY: Float32 = 440.0
    static let AV_UNIT_VELOCITY = Float32(2.0 * .pi / Self.AV_SAMPLERATE)
    static let AV_MODULATOR_FREQUENCY: Float32 = 679.0
    static let AV_MODULATOR_AMPLITUDE: Float32 = 0.8
    static let AV_CARRIER_VELOCITY = Self.AV_CARRIER_FREQUENCY * Self.AV_UNIT_VELOCITY
    static let AV_MODULATOR_VELOCITY = Self.AV_MODULATOR_FREQUENCY * Self.AV_UNIT_VELOCITY
    static let AV_SAMPLES_PER_BUFFER: AVAudioFrameCount = 1024 * 16

    static let AV_FORMAT = AVAudioFormat(
        commonFormat: Self.AV_LINEAR_PCM_BIT_DEPTH_FORMAT,
        sampleRate  : Self.AV_SAMPLERATE,
        channels    : Self.AV_CHANNELS,
        interleaved : Self.AV_IS_INTERLEAVED
    )!

    let pianoShape: [Float] = [
          0.07656860,  0.14749146,  0.20239258,  0.23590088,  0.24707031,  0.23776245,
          0.21069336,  0.16882324,  0.11560058,  0.05490112, -0.01000976, -0.07580566,
         -0.13690186, -0.18597412, -0.21728516, -0.22830200, -0.21929932, -0.19100952,
         -0.14349365, -0.07897949, -0.00405883
    ]

    private let avEngine: AVAudioEngine

    init(avEngine: AVAudioEngine) {
        self.avEngine = avEngine
    }

    var body: some View {
        VStack {

            Text("Generate")
                .font(.system(size: 12, weight: .bold))

            VStack {
                Button { self.byEtaloneMass() } label: { Text("by etalone mass").frame(width: 180) }
                Button { self.byEtalone()     } label: { Text("by etalone")     .frame(width: 180) }
                Button { self.byMath()        } label: { Text("by math")        .frame(width: 180) }
                Button { self.etaloneSave()   } label: { Text("etalone save")   .frame(width: 180) }
            }

        }
    }

    func byEtaloneMass() {
        let repeatCount = 500
        let avPlayerNode = AVAudioPlayerNode()
        let avBuffer = AVAudioPCMBuffer(
            pcmFormat    : Self.AV_FORMAT,
            frameCapacity: Self.AV_SAMPLES_PER_BUFFER
        )!

        avBuffer.frameLength = UInt32(self.pianoShape.count * repeatCount)
        avBuffer.floatMatrixSet(
            [
                self.pianoShape,
                self.pianoShape
            ],
            size: UInt64(
                avBuffer.frameLength
            )
        )

        self.avEngine.attach(avPlayerNode)
        self.avEngine.connect(
            avPlayerNode,
            to    : self.avEngine.mainMixerNode,
            format: avBuffer.format
        )
        if self.avEngine.isRunning == false {
            try! self.avEngine.start()
        }

        avPlayerNode.scheduleBuffer(avBuffer)
        avPlayerNode.play()
    }

    func byEtalone() {
        let avPlayerNode = AVAudioPlayerNode()
        let avBuffer = AVAudioPCMBuffer(
            pcmFormat    : Self.AV_FORMAT,
            frameCapacity: Self.AV_SAMPLES_PER_BUFFER
        )!

        avBuffer.frameLength = Self.AV_SAMPLES_PER_BUFFER
        let channelL = avBuffer.floatChannelData?[0]
        let channelR = avBuffer.floatChannelData?[1]
        var sampleTime: Int = 0
        for sampleIndex in 0 ..< Int(Self.AV_SAMPLES_PER_BUFFER) {
            let sample = self.pianoShape[sampleTime % self.pianoShape.count]
            channelL?[sampleIndex] = sample
            channelR?[sampleIndex] = sample
            sampleTime += 1
        }

        self.avEngine.attach(avPlayerNode)
        self.avEngine.connect(
            avPlayerNode,
            to    : self.avEngine.mainMixerNode,
            format: avBuffer.format
        )
        if self.avEngine.isRunning == false {
            try! self.avEngine.start()
        }

        avPlayerNode.scheduleBuffer(avBuffer)
        avPlayerNode.play()
    }

    func byMath() {
        let generator: (Float) -> Float = { sampleTime in
            return sin(Self.AV_CARRIER_VELOCITY   * Float(sampleTime) + Self.AV_MODULATOR_AMPLITUDE *
                   sin(Self.AV_MODULATOR_VELOCITY * Float(sampleTime))
            )
        }
        let avPlayerNode = AVAudioPlayerNode()
        let avBuffer = AVAudioPCMBuffer(
            pcmFormat    : Self.AV_FORMAT,
            frameCapacity: Self.AV_SAMPLES_PER_BUFFER
        )!

        avBuffer.frameLength = Self.AV_SAMPLES_PER_BUFFER
        let channelL = avBuffer.floatChannelData?[0]
        let channelR = avBuffer.floatChannelData?[1]
        var sampleTime: Int = 0
        for sampleIndex in 0 ..< Int(Self.AV_SAMPLES_PER_BUFFER) {
            let sample = generator(Float(sampleTime))
            channelL?[sampleIndex] = sample
            channelR?[sampleIndex] = sample
            sampleTime += 1
        }

        self.avEngine.attach(avPlayerNode)
        self.avEngine.connect(
            avPlayerNode,
            to    : self.avEngine.mainMixerNode,
            format: avBuffer.format
        )
        if self.avEngine.isRunning == false {
            try! self.avEngine.start()
        }

        avPlayerNode.scheduleBuffer(avBuffer)
        avPlayerNode.play()
    }

    func etaloneSave() {
        do {

            let avBuffer = AVAudioPCMBuffer.etaloneGenerate(
                channels: 2,
                size: 10
            )!

            let avFileDst = try AVAudioFile(
                forWriting  : URL(filePath: FILE_PATH_RESULT),
                settings    : avBuffer.format.settings,
                commonFormat: avBuffer.format.commonFormat,
                interleaved : avBuffer.format.isInterleaved)
            try avFileDst.write(from: avBuffer)
            avFileDst.close()

        } catch {
            print("Error: \(error).")
        }
    }

}
