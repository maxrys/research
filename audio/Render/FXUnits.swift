
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

struct FXUnits {

    static let PITCH_STEP = 100

    public var pitch      = AVAudioUnitTimePitch()
    public var speed      = AVAudioUnitVarispeed()
    public var delay      = AVAudioUnitDelay()
    public var distortion = AVAudioUnitDistortion()
    public var reverb     = AVAudioUnitReverb()
    public var equalizer  = AVAudioUnitEQ()

    func link(engine: AVAudioEngine, playerNode: AVAudioPlayerNode, format: AVAudioFormat) {

        engine.attach(self.pitch)
        engine.attach(self.speed)
        engine.attach(self.delay)
        engine.attach(self.distortion)
        engine.attach(self.reverb)
        engine.attach(self.equalizer)

        engine.connect(
                    playerNode,
                to: self.pitch,
            format: format)
        engine.connect(
                    self.pitch,
                to: self.speed,
            format: format)
        engine.connect(
                    self.speed,
                to: self.delay,
            format: format)
        engine.connect(
                    self.delay,
                to: self.distortion,
            format: format)
        engine.connect(
                    self.distortion,
                to: self.reverb,
            format: format)
        engine.connect(
                    self.reverb,
                to: self.equalizer,
            format: format)
        engine.connect(
                    self.equalizer,
                to: engine.mainMixerNode,
            format: format
        )

    }

    func stateApply(state: StateFX) {
     /* ╔═══════╦═══════════╗
        ║ value ║ multipler ║
        ╠═══════╬═══════════╣
        │   5   │    +2     │
        │   4   │    +1     │
        │   3   │     0     │ ← center
        │   2   │    -1     │
        │   1   │    -2     │
        └───────┴───────────┘ */
        let pitchMultipler = Int(state.levelY) - (Int(state.rows) / 2 + 1)
        let value_pitch = Float(
            Self.PITCH_STEP * pitchMultipler
        )

     /* ╔═══════════╦───┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬───────┐
        ║   value   ║ 1 │   2  │   3  │   4  │   5  │   6  │   7  │   8  │   9   │ ← max
        ╠═══════════╬───┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼───────┤
        ║ wetDryMix ║ 0 │ 12.5 │ 25.0 │ 37.5 │ 50.0 │ 62.5 │ 75.0 │ 87.5 │ 100.0 │
        ╚═══════════╩───┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴───────┘ */
        let value_wetDryMix = Float(state.levelX) / Float(state.cols) * 100.0

        self.pitch.bypass         = state.isEnabledGet(.pitch     ) == false
        self.speed.bypass         = state.isEnabledGet(.speed     ) == false
        self.delay.bypass         = state.isEnabledGet(.delay     ) == false
        self.distortion.bypass    = state.isEnabledGet(.distortion) == false
        self.reverb.bypass        = state.isEnabledGet(.reverb    ) == false
        self.equalizer.bypass     = state.isEnabledGet(.equalizer ) == false

        self.pitch.pitch          = value_pitch
        self.delay.wetDryMix      = value_wetDryMix
        self.distortion.wetDryMix = value_wetDryMix
        self.reverb.wetDryMix     = value_wetDryMix
        self.delay.delayTime      =    1.0          /*    0 ←     1 →     2 */
        self.delay.feedback       =   10.0          /* -100 ←    50 →   100 */
        self.delay.lowPassCutoff  = 1000.0          /*   10 ← 15000 → 22050 */
        self.distortion.preGain   =   -0.9          /*  -80 ←  -0.9 →    20 */
    }

}
