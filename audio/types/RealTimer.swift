
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import QuartzCore

final class RealTimer {

    private var timer: Timer?
    private var startedAt: Tertia = 0
    private var onTick: (Tertia) -> Void

    init(onTick: @escaping (Tertia) -> Void = { _ in }) {
        self.onTick = onTick
    }

    func timeCurrentGet() -> Tertia {
        return Tertia.currentGet() - self.startedAt
    }

    func start(tickInterval: Double = 1.0 / 24, from offset: Tertia = 0) {
        self.timer = Timer(
            timeInterval: tickInterval,
            repeats: true,
            block: { _ in
                self.onTick(
                    self.timeCurrentGet()
                )
            }
        )
        self.timer!.tolerance = 0.0
        self.startedAt = Tertia.currentGet() - offset
        RunLoop.current.add(
            self.timer!,
            forMode: .common
        )
    }

    func stopAndDestroy() {
        self.timer?.invalidate()
        self.timer = nil
    }

}
