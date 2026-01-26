
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct ViewRenderPage: View {

    private let avEngine: AVAudioEngine
    private var trackOsc: TrackOsc
    private var track: Track

    init(avEngine: AVAudioEngine) {
        /* global engine (not for render) */
        self.avEngine = avEngine

        /* track Osc preparation */
        let stateInitiallyFX = StateFX()

        self.trackOsc = TrackOsc(
            cols: 9,
            rows: 9,
            sample: try! AVAudioPCMBuffer(
                file: AVAudioFile(
                    forReading: FILE_URL_OSCILLATOR
                )
            )!
        )

        stateInitiallyFX.levelsSet(levelX: 1, levelY: 1, cols: 9, rows: 9)
        self.trackOsc.noteOscInsert(time:  0, stateFX: StateFX(from: stateInitiallyFX, levelX: 1, levelY: 1)); self.trackOsc.noteOscUpdate(time: 10)
        self.trackOsc.noteOscInsert(time: 10, stateFX: StateFX(from: stateInitiallyFX, levelX: 2, levelY: 2)); self.trackOsc.noteOscUpdate(time: 20)
        self.trackOsc.noteOscInsert(time: 20, stateFX: StateFX(from: stateInitiallyFX, levelX: 3, levelY: 3)); self.trackOsc.noteOscUpdate(time: 30)
        self.trackOsc.noteOscInsert(time: 30, stateFX: StateFX(from: stateInitiallyFX, levelX: 4, levelY: 4)); self.trackOsc.noteOscUpdate(time: 40)

        stateInitiallyFX.isEnabledSet(.distortion, true)
        self.trackOsc.noteOscInsert(time: 50, stateFX: StateFX(from: stateInitiallyFX, levelX: 6, levelY: 6)); self.trackOsc.noteOscUpdate(time: 60)
        self.trackOsc.noteOscInsert(time: 60, stateFX: StateFX(from: stateInitiallyFX, levelX: 7, levelY: 7)); self.trackOsc.noteOscUpdate(time: 70)
        self.trackOsc.noteOscInsert(time: 70, stateFX: StateFX(from: stateInitiallyFX, levelX: 8, levelY: 8)); self.trackOsc.noteOscUpdate(time: 80)
        self.trackOsc.noteOscInsert(time: 80, stateFX: StateFX(from: stateInitiallyFX, levelX: 9, levelY: 9)); self.trackOsc.noteOscUpdate(time: 90)

        /* track preparation */
        let trackSamples = Matrix<AVAudioPCMBuffer>()
        for (_, info) in ModelBanks.select(bankID: "hihat4x4").samples {
            trackSamples[
                info.levelX,
                info.levelY
            ] = info.buffer
        }

        self.track = Track(
            cols: 4,
            rows: 4,
            samples: trackSamples
        )

        self.track.noteInsert(levelX: 1, levelY: 1, time:  0, length: 10)
        self.track.noteInsert(levelX: 2, levelY: 2, time: 10, length: 20)
        self.track.noteInsert(levelX: 3, levelY: 3, time: 20, length: 30)
        self.track.noteInsert(levelX: 3, levelY: 3, time: 50, length: 30)
        self.track.noteInsert(levelX: 3, levelY: 3, time: 35, length: 30) /* overlaps the previous note */
        self.track.noteInsert(levelX: 4, levelY: 4, time: 30, length: 40)
    }

    @ViewBuilder func button(title: String, onClick: @escaping () -> Void = { }) -> some View {
        Button { onClick() } label: {
            Text(title)
                .font(.system(size: 8, weight: .light))
                .frame(width: 45, height: 20)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .shadow(
                            color: .black.opacity(0.3),
                            radius: 1,
                            y: 0.5
                        )
                }
        }.buttonStyle(.plain)
    }

    var body: some View {
        VStack {

            Text("Render")
                .font(.system(size: 12, weight: .bold))

            HStack(spacing: 5) {

                self.button(title: "Play Osc", onClick: { try! self.play( self.renderOsc() ) })
                self.button(title: "Save Osc", onClick: { try! self.save( self.renderOsc() ) })
                self.button(title: "Play"    , onClick: { try! self.play( self.render()    ) })
                self.button(title: "Save"    , onClick: { try! self.save( self.render()    ) })

            }

        }
    }

    func renderOsc() throws -> AVAudioPCMBuffer {
        return try self.trackOsc.render()
    }

    func render() throws -> AVAudioPCMBuffer {
        return try self.track.render()
    }

    func play(_ buffer: AVAudioPCMBuffer) throws {
        let avPlayerNode = AVAudioPlayerNode()
        self.avEngine.attach(avPlayerNode)
        self.avEngine.connect(
            avPlayerNode,
            to    : self.avEngine.mainMixerNode,
            format: buffer.format
        )
        if self.avEngine.isRunning == false {
            try self.avEngine.start()
        }
        avPlayerNode.scheduleSegment(
            buffer,
            from: 0,
            size: buffer.frameLength,
            at  : nil)
        avPlayerNode.play()
    }

    func save(_ buffer: AVAudioPCMBuffer) throws {
        let avFileDst = try AVAudioFile(
            forWriting  : URL(filePath: FILE_PATH_RESULT),
            settings    : buffer.format.settings,
            commonFormat: buffer.format.commonFormat,
            interleaved : buffer.format.isInterleaved
        )
        try avFileDst.write(
            from: buffer
        )
    }

}
