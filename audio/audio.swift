
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

let AV_ENGINE = AVAudioEngine()
#if os(iOS)
    let AV_SESSION = AVAudioSession.sharedInstance()
#endif

enum PlayMode {

    case pause
    case record
    case play

    public var isActive: Bool {
        get {
            self == .record ||
            self == .play
        }
    }

}

enum LoopMode: String {

    case once
    case loop

    static func fromString(value: String) -> LoopMode {
        switch value {
            case "once": return .once
            case "loop": return .loop /* repeat while pressing */
            default    : return .once
        }
    }

}

enum FXType {

    case pitch
    case speed
    case delay
    case distortion
    case reverb
    case equalizer

}
