
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import Combine

struct TimerPublisher: View {

    @State var currentTime: Date = Date()

    var timer: Timer.TimerPublisher
    var timerCanceller: Cancellable?

    var body: some View {

        Text("\(currentTime)")
            .onReceive(self.timer) { newCurrentTime in
                self.currentTime = newCurrentTime
            }

        VStack {
            Button {
                self.timerCanceller?.cancel()
            } label: {
                Text("stop")
            }
        }

    }

    init() {
        self.timer = Timer.publish(
            every: 1,
            tolerance: 0.0,
            on: RunLoop.main,
            in: RunLoop.Mode.common,
            options: nil
        )

        let _ = self.timer.sink { secondsLeft in
            print(secondsLeft)
        }

        self.timerCanceller = self.timer.connect()
    }


}
