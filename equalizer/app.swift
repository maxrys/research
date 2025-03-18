
import SwiftUI

typealias Size = CGFloat

extension Numeric {

    func fixBounds(min: Self = 0, max: Self) -> Self where Self: Comparable {
        if self < min {return min}
        if self > max {return max}
        return self
    }

}

@Observable final class EqState {

    var canvasVisibleAreaMinX: Size = 0
    var canvasVisibleAreaMaxX: Size = 0
    var levels: [Double] = []

}

@main struct app: App {

    private var eqState = EqState()
    private let eqLevelsCount: Int = 128
    private let eqLevelWidth: Size = 10.0
    private let eqHeight: Size = 150
    private let timeInterval: Double = 1 / 24
    private var timer: Timer!

    var body: some Scene {
        WindowGroup {
            Equalizer(
                height    : self.eqHeight,
                levelWidth: self.eqLevelWidth,
                state     : self.eqState
            )
            .background(.gray)
            .padding(.horizontal, 12)
        }
    }

    init() {
        self.eqState.levels = Array(
            repeating: 0.0,
            count: self.eqLevelsCount
        )
        self.timer = Timer(
            timeInterval: self.timeInterval,
            repeats: true,
            block: self.onTimerTick
        )
        self.timer.tolerance = 0.0
        RunLoop.current.add(
            self.timer,
            forMode: .common
        )
    }

    func onTimerTick(_ : Timer) {
        for index in 0 ..< self.eqState.levels.count {
            self.eqState.levels[index] = Size.random(
                in: 0...1
            )
        }
    }

}
