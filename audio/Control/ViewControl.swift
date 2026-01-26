
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct ViewControl: View {

    @Observable final class ControlState {
        var playMode: PlayMode = .pause
        var time: Tertia = 0
        @ObservationIgnored var timer: RealTimer!
    }

    private var player: Player!
    private let avEngine: AVAudioEngine
    private var state: ControlState

    init(avEngine: AVAudioEngine) {
        self.avEngine = avEngine
        self.state = ControlState()
        self.player = Player(
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
        self.state.time = 0
    }

    func onChangeProgress(value: Double) {
        self.player.setStartingFrame(Int64(Double(self.player.length) * value))
        self.state.time = Tertia(Double(self.player.duration) * value * Double(TERTIA_PER_SECOND))
    }

    var body: some View {
        VStack {

            Text("Control")
                .font(.system(size: 12, weight: .bold))

            VStack {

                Button {
                    self.state.playMode = .play
                    self.state.timer.start(from: self.state.time)
                    self.player.play()
                } label: {
                    Image(systemName: "play.fill")
                }.disabled(self.state.playMode == .play)

                Button {
                    self.state.playMode = .pause
                    self.player.stop()
                    self.state.timer.stopAndDestroy()
                } label: {
                    Image(systemName: "pause.fill")
                }.disabled(self.state.playMode == .pause)

                Text("\(self.state.time.toString())")

                Progress(
                    value: Double(self.player.getLastRenderFrame) / Double(self.player.length),
                    onChange: self.onChangeProgress
                ).frame(width: 75, height: 10)

            }
        }

    }

}
