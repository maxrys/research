
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

let AV_ENGINE = AVAudioEngine()
#if os(iOS)
    let AV_SESSION = AVAudioSession.sharedInstance()
#endif

@main struct ThisApp: App {
    var body: some Scene {
        Window("Main", id: "main") {
            Text("Audio Mix")
        }
    }

    init() {
        /* mix */
        let mix = AVAudioEngine().mix([
            AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 7000)!,
            AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 3000)!,
            AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 4000)!,
            AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 5000)!,
            AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 6000)!,
        ])!
        /* play */
        let avPlayerNode = AVAudioPlayerNode()
        AV_ENGINE.attach(avPlayerNode)
        AV_ENGINE.connect(
                    avPlayerNode,
                to: AV_ENGINE.mainMixerNode,
            format: AVAudioEngine.AV_DEFAULT_FORMAT
        )
        if AV_ENGINE.isRunning == false {
            try! AV_ENGINE.start()
        }
        avPlayerNode.scheduleBuffer(mix)
        avPlayerNode.play()
        dump(
            mix.frameLength
        )
    }

}
