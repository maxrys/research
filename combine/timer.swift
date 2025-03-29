
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation
import Combine

func test_timer() {

    var timersCollection: [AnyCancellable] = []

    let timer = Timer.publish(
        every: 1,
        tolerance: 0.0,
        on: RunLoop.main,
        in: RunLoop.Mode.common,
        options: nil
    )

    timer
        .sink { secondsLeft in
            print(secondsLeft)
        }
        .store(
            in: &timersCollection
        )

    let result = timer.connect()

}
