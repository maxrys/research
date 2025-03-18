
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct ViewControl: View {

    @Observable final class State {
        var playMode: PlayMode = .pause
        var timerOffset: Tertia = 0
        @ObservationIgnored var timer: RealTimer!
        @ObservationIgnored var player: PlayerFile!
    }

    private var state: State
    private let avEngine: AVAudioEngine

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
     // NotificationCenter.default.addObserver(
     //     self.avPlayerNode,
     //     selector: #selector(self.onStop),
     //     name: AVCaptureSession.didStopRunningNotification,
     //     object: nil
     // )
     // NotificationCenter.default.addObserver(
     //     self.avPlayerNode,
     //     selector: #selector(self.onStop),
     //     name: .AVPlayerItemDidPlayToEndTime,
     //     object: nil
     // )
    }

    func onTickTimer(time: Tertia) {
        self.state.timerOffset = time
    }

    func onEndPlaying() {
        self.state.playMode = .pause
        self.state.timer.stopAndDestroy()
    }

    var body: some View {
        VStack {

            Text("Control")
                .font(.system(size: 12, weight: .bold))

            VStack {

                Button {
                    self.state.playMode = .play
                    self.state.timer.start(tickInterval: 1.0 / 24)
                    self.state.player.play()
                } label: {
                    Text("play")
                        .frame(width: 50)
                }
                .disabled(
                    self.state.playMode == .play
                )

                Button {
                    self.state.playMode = .pause
                    self.state.player.stop()
                    self.state.timer.stopAndDestroy()
                } label: {
                    Text("stop")
                        .frame(width: 50)
                }
                .disabled(
                    self.state.playMode == .pause
                )

                Text("\(self.state.timerOffset.toString())")

            }
        }

    }

}
