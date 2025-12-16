
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

struct TaskProgress: AsyncSequence {

    typealias Element = Double

    let totalSteps: Int

    struct AsyncIterator: AsyncIteratorProtocol {
        let totalSteps: Int
        var currentStep = 0
        mutating func next() async -> Double? {
            guard self.currentStep < self.totalSteps else { return nil }
            let progress = Double(self.currentStep) / Double(self.totalSteps)
            try? await Task.sleep(nanoseconds: 500_000_000)
            self.currentStep += 1
            return progress
        }
    }

    func makeAsyncIterator() -> Self.AsyncIterator {
        return Self.AsyncIterator(
            totalSteps: self.totalSteps
        )
    }

}
