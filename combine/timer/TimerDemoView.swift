
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct TimerDemoView: View {

    var offset: ValueState<UInt>
    var timer: Timer.Custom!

    var body: some View {
        Text("current offset: \(self.offset.value)")
        Button { self.timer.startOrRenew() } label: { Text("start or renew") }
        Button { self.timer.stopAndReset() } label: { Text("stop and reset") }
    }

    init() {
        self.offset = ValueState<UInt>(0)
        self.timer = Timer.Custom(
            immediately: false,
            repeats: .infinity,
            delay: 0.1,
            onTick: self.onTimerTick
        )
    }

    func onTimerTick(timer: Timer.Custom) {
        self.offset.value = timer.i
    }

}
