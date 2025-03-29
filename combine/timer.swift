
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@Observable final class TimerPublisherState {
    var offset: Double = 0
}

struct TimerPublisher: View {

    var state: TimerPublisherState
    var timer: RealTimer!

    var body: some View {
        Text("current offset: \(self.state.offset)")
        Button { self.timer.start() } label: { Text("start") }
        Button { self.timer.stop()  } label: { Text("stop") }
    }

    init() {
        self.state = TimerPublisherState()
        self.timer = RealTimer(
            onTick: self.onTimerTick
        )
    }

    func onTimerTick(offset: Double) {
        self.state.offset = offset
    }

}
