
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

struct TaskProgress: AsyncSequence {

    typealias Element = Double

    struct AsyncIterator: AsyncIteratorProtocol {
        let totalSteps: Int
        var currentStep = 0
        mutating func next() async -> Double? {
            guard self.currentStep < self.totalSteps + 1 else { return nil }
            let progress = Double(self.currentStep) / Double(self.totalSteps)
            try? await Task.sleep(nanoseconds: 500_000_000)
            self.currentStep += 1
            return progress
        }
    }

    let totalSteps: Int

    func makeAsyncIterator() -> Self.AsyncIterator {
        return Self.AsyncIterator(
            totalSteps: self.totalSteps
        )
    }

}
