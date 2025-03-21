
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct ViewControl: View {

    @Observable final class State {
        var playMode: PlayMode = .pause
        var time: Tertia = 0
        var from: AVAudioFramePosition = 0
        @ObservationIgnored var timer: RealTimer!
        @ObservationIgnored var player: PlayerFile!
    }

    private let avEngine: AVAudioEngine
    private var state: State

    init(avEngine: AVAudioEngine) {
        self.avEngine = avEngine
        self.state = State()
        self.state.player = PlayerFile(
            FILE_URL_PIANO,
            engine: self.avEngine,
            onStop: self.onEndPlaying
        )!
        self.state.timer = RealTimer(
            onTick: self.onTickTimer
        )
    }

    func onTickTimer(time: Tertia) {
        self.state.time = time
    }

    func onEndPlaying() {
        self.state.playMode = .pause
        self.state.timer.stopAndDestroy()
    }

    func onChangeProgress(value: Double) {
        self.state.from = Int64(Double(self.state.player.length) * value)
        self.state.time = Tertia(self.state.player.duration * Double(TERTIA_PER_SECOND) * value)
    }

    var body: some View {
        VStack {

            Text("Control")
                .font(.system(size: 12, weight: .bold))

            VStack {

                Button {
                    self.state.playMode = .play
                    self.state.timer.start()
                    self.state.player.play(
                        from: self.state.from
                    )
                } label: {
                    Image(systemName: "play.fill")
                }.disabled(self.state.playMode == .play)

                Button {
                    self.state.playMode = .pause
                    self.state.player.stop()
                    self.state.timer.stopAndDestroy()
                } label: {
                    Image(systemName: "pause.fill")
                }.disabled(self.state.playMode == .pause)

                Text("\(self.state.time.toString())")

                Progress(
                    value: Double(self.state.time) / Double(TERTIA_PER_SECOND) / self.state.player.duration,
                    onChange: self.onChangeProgress
                ).frame(width: 75, height: 10)

            }
        }

    }

}
