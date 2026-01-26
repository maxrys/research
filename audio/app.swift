
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

let FILE_URL_PIANO        = Bundle.main.url(forResource: "piano"       , withExtension: "wav")!
let FILE_URL_PIANO_STEREO = Bundle.main.url(forResource: "piano-stereo", withExtension: "wav")!
let FILE_URL_OSCILLATOR   = Bundle.main.url(forResource: "oscillator"  , withExtension: "wav")!
let FILE_PATH_RESULT      = "/Users/max/Desktop/result.wav"

@main struct ThisApp: App {

    @AppStorage("appTitle") var name = "No title"

    init() {
        #if os(iOS)
            try! AV_SESSION.setActive(true)
            try! AV_SESSION.setCategory(.playback)
        #endif
        UserDefaults.standard.register(defaults: [
            "appTitle": "AVFoundation Demo"
        ])
    }

    var body: some Scene {
        Window("Main", id: "main") {
            mainScene
                .padding(20)
                .frame(width: 650, height: 500)
                .environment(\.layoutDirection, .leftToRight)
                .environment(\.colorScheme, .light)
        }
    }

    @ViewBuilder var mainScene: some View {

        Text(self.name)
            .font(.system(size: 20, weight: .light))
            .padding(.bottom, 30)

        VStack(spacing: 20) {

            HStack(alignment: .top, spacing: 30) {

                ViewPlayPage(
                    avEngine: AV_ENGINE
                )

                VStack(spacing: 14) {
                    ViewGenerate  (avEngine: AV_ENGINE)
                    ViewRenderPage(avEngine: AV_ENGINE)
                }

                VStack(spacing: 31) {
                    ViewControl (avEngine: AV_ENGINE)
                    ViewCleaning(avEngine: AV_ENGINE)
                }

            }

            VewPadPage(
                avEngine: AV_ENGINE
            )

        }

    }

}
