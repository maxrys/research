
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct ViewControl: View {

    @Observable final class State {
        var playMode: PlayMode = .pause
        var time: Tertia = 0
        @ObservationIgnored var timer: RealTimer!
        @ObservationIgnored var player: PlayerFile!
    }

    private var state: State
    private let avEngine: AVAudioEngine
    private var duration: Double!

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
        self.duration = self.state.player.getDuration()
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
        self.state.time = time
    }

    func onEndPlaying() {
        self.state.playMode = .pause
        self.state.timer.stopAndDestroy()
    }

    @ViewBuilder func progress(value: Double = 0.5) -> some View {
        ZStack(alignment: .leading) {
            GeometryReader { reader in
                let widthByValue = reader.size.width * (value).fixBounds(max: 1)
                Color(.gray).frame(width: reader.size.width, height: reader.size.height)
                Color(.blue).frame(width: widthByValue     , height: reader.size.height)
            }
        }
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
                    Image(systemName: "play.fill")
                }
                .disabled(
                    self.state.playMode == .play
                )

                Button {
                    self.state.playMode = .pause
                    self.state.player.stop()
                    self.state.timer.stopAndDestroy()
                } label: {
                    Image(systemName: "pause.fill")
                }
                .disabled(
                    self.state.playMode == .pause
                )

                Text("\(self.state.time.toString())")

                progress(
                    value: Double(self.state.time) / Double(TERTIA_PER_SECOND) / self.duration
                ).frame(width: 75, height: 10)

            }
        }

    }

}
